//
//  OllamaKit+Models.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously retrieves a list of available models from the Ollama API.
    ///
    /// This method returns an ``OKModelResponse`` containing the details of the available models.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    /// let models = try await ollamaKit.models()
    /// ```
    ///
    /// - Returns: An ``OKModelResponse`` object listing the available models.
    /// - Throws: An error if the request fails or the response can't be decoded.
    public func models() async throws -> OKModelResponse {
        let request = AF.request(router.models).validate()
        let response = request.serializingDecodable(OKModelResponse.self, decoder: decoder)
        let value = try await response.value
        
        return value
    }
    
    /// Retrieves a list of available models from the Ollama API as a Combine publisher.
    ///
    /// This method provides a reactive approach to fetch model data, returning a Combine publisher that emits an ``OKModelResponse`` with details of available models.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    ///
    /// ollamaKit.models()
    ///     .sink(receiveCompletion: { completion in
    ///         // Handle completion
    ///     }, receiveValue: { modelResponse in
    ///         // Handle the received model response
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Returns: A `AnyPublisher<OKModelResponse, AFError>` that emits the list of available models.
    public func models() -> AnyPublisher<OKModelResponse, AFError> {
        let request = AF.request(router.models).validate()
        
        return request
            .publishDecodable(type: OKModelResponse.self, decoder: decoder).value()
            .eraseToAnyPublisher()
    }
}
