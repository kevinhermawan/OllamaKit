//
//  StreamingDelegate.swift
//
//
//  Created by Kevin Hermawan on 09/06/24.
//

@preconcurrency import Combine
import Foundation

internal class StreamingDelegate: NSObject, URLSessionDataDelegate, @unchecked Sendable {
    private let subject = PassthroughSubject<Data, URLError>()
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        subject.send(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            subject.send(completion: .failure(error as? URLError ?? URLError(.unknown)))
        } else {
            subject.send(completion: .finished)
        }
    }
    
    func publisher() -> AnyPublisher<Data, URLError> {
        subject.eraseToAnyPublisher()
    }
}
