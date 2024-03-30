//
//  OllamaKit+GenerateEmbeddings.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously generates embeddings from a specific model from the Ollama API.
    ///
    /// This method accepts ``OKGenerateEmbeddingsRequestData`` and returns an ``OKGenerateEmbeddingsResponse`` containing embeddings from the requested model.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKGenerateEmbeddingsRequestData(/* parameters */)
    /// let generateEmbeddings = try await ollamaKit.generateEmbeddings(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKGenerateEmbeddingsRequestData`` used to query the API for generating specific model embeddings.
    /// - Returns: An ``OKGenerateEmbeddingsResponse`` containing the embeddings from the model.
    /// - Throws: An error if the request fails or the response can't be decoded.
    public func generateEmbeddings(data: OKGenerateEmbeddingsRequestData) async throws -> OKGenerateEmbeddingsResponse {
        let request = AF.request(router.generateEmbeddings(data: data)).validate()
        let response = request.serializingDecodable(OKGenerateEmbeddingsResponse.self, decoder: decoder)
        let value = try await response.value
        
        return value
    }
    
    /// Retrieves embeddings from a specific model from the Ollama API as a Combine publisher.
    ///
    /// This method provides a reactive approach to generate embeddings. It accepts ``OKGenerateEmbeddingsRequestData`` and returns a Combine publisher that emits an ``OKGenerateEmbeddingsResponse`` upon successful retrieval.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKGenerateEmbeddingsRequestData(/* parameters */)
    ///
    /// ollamaKit.generateEmbeddings(data: requestData)
    ///     .sink(receiveCompletion: { completion in
    ///         // Handle completion
    ///     }, receiveValue: { generateEmbeddingsResponse in
    ///         // Handle the received model info response
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Parameter data: The ``OKGenerateEmbeddingsRequestData`` used to query the API for embeddings from a specific model.
    /// - Returns: A `AnyPublisher<OKGenerateEmbeddingsResponse, AFError>` that emits embeddings.
    public func generateEmbeddings(data: OKGenerateEmbeddingsRequestData) -> AnyPublisher<OKGenerateEmbeddingsResponse, AFError> {
        let request = AF.request(router.generateEmbeddings(data: data)).validate()
        
        return request
            .publishDecodable(type: OKGenerateEmbeddingsResponse.self, decoder: decoder).value()
            .eraseToAnyPublisher()
    }
}
