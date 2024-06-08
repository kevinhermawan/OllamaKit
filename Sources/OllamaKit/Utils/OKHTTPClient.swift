//
//  OKHTTPClient.swift
//
//
//  Created by Kevin Hermawan on 08/06/24.
//

import Combine
import Foundation

internal struct OKHTTPClient {
    private let decoder: JSONDecoder = .default
    
    static let shared = OKHTTPClient()
    
    func sendRequest(for request: URLRequest) async throws -> Void {
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
    
    func sendRequest<T: Decodable>(for request: URLRequest, with responseType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func sendRequest<T: Decodable>(for request: URLRequest, with responseType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func sendRequest(for request: URLRequest) -> AnyPublisher<Void, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                return Void()
            }
            .eraseToAnyPublisher()
    }
    
    func streamRequest<T: Decodable>(for request: URLRequest, with responseType: T.Type) -> AsyncThrowingStream<T, Error> {
        return AsyncThrowingStream { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                
                guard let data = data else {
                    continuation.finish(throwing: URLError(.badServerResponse))
                    return
                }
                
                var buffer = Data()
                buffer.append(data)
                
                while let chunk = extractNextJSON(from: &buffer) {
                    do {
                        let response = try decoder.decode(T.self, from: chunk)
                        continuation.yield(response)
                    } catch {
                        continuation.finish(throwing: error)
                        return
                    }
                }
                
                continuation.finish()
            }
            
            task.resume()
        }
    }
    
    func streamRequest<T: Decodable>(for request: URLRequest, with responseType: T.Type) -> AnyPublisher<T, Error> {
        let subject = PassthroughSubject<T, Error>()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let data = data else {
                subject.send(completion: .failure(URLError(.badServerResponse)))
                return
            }
            
            var buffer = Data()
            buffer.append(data)
            
            while let chunk = extractNextJSON(from: &buffer) {
                do {
                    let response = try decoder.decode(T.self, from: chunk)
                    subject.send(response)
                } catch {
                    subject.send(completion: .failure(error))
                    return
                }
            }
            
            subject.send(completion: .finished)
        }
        
        task.resume()
        
        return subject.eraseToAnyPublisher()
    }
    
    func extractNextJSON(from buffer: inout Data) -> Data? {
        var isEscaped = false
        var isWithinString = false
        var nestingDepth = 0
        var objectStartIndex = buffer.startIndex
        
        for (index, byte) in buffer.enumerated() {
            let character = Character(UnicodeScalar(byte))
            
            if isEscaped {
                isEscaped = false
            } else if character == "\\" {
                isEscaped = true
            } else if character == "\"" {
                isWithinString.toggle()
            } else if !isWithinString {
                switch character {
                case "{":
                    nestingDepth += 1
                    if nestingDepth == 1 {
                        objectStartIndex = index
                    }
                case "}":
                    nestingDepth -= 1
                    if nestingDepth == 0 {
                        let range = objectStartIndex..<buffer.index(after: index)
                        let jsonObject = buffer.subdata(in: range)
                        buffer.removeSubrange(range)
                        
                        return jsonObject
                    }
                default:
                    break
                }
            }
        }
        
        return nil
    }
}
