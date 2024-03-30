//
//  OllamaKit+ModelInfo.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously retrieves detailed information for a specific model from the Ollama API.
    ///
    /// This method accepts ``OKModelInfoRequestData`` and returns an ``OKModelInfoResponse`` containing detailed information about the requested model.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKModelInfoRequestData(/* parameters */)
    /// let modelInfo = try await ollamaKit.modelInfo(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKModelInfoRequestData`` used to query the API for specific model information.
    /// - Returns: An ``OKModelInfoResponse`` containing detailed information about the model.
    /// - Throws: An error if the request fails or the response can't be decoded.
    public func modelInfo(data: OKModelInfoRequestData) async throws -> OKModelInfoResponse {
        let request = AF.request(router.modelInfo(data: data)).validate()
        let response = request.serializingDecodable(OKModelInfoResponse.self, decoder: decoder)
        let value = try await response.value
        
        return value
    }
    
    /// Retrieves detailed information for a specific model from the Ollama API as a Combine publisher.
    ///
    /// This method provides a reactive approach to fetch detailed model information. It accepts ``OKModelInfoRequestData`` and returns a Combine publisher that emits an ``OKModelInfoResponse`` upon successful retrieval.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKModelInfoRequestData(/* parameters */)
    ///
    /// ollamaKit.modelInfo(data: requestData)
    ///     .sink(receiveCompletion: { completion in
    ///         // Handle completion
    ///     }, receiveValue: { modelInfoResponse in
    ///         // Handle the received model info response
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Parameter data: The ``OKModelInfoRequestData`` used to query the API for specific model information.
    /// - Returns: A `AnyPublisher<OKModelInfoResponse, AFError>` that emits detailed information about the model.
    public func modelInfo(data: OKModelInfoRequestData) -> AnyPublisher<OKModelInfoResponse, AFError> {
        let request = AF.request(router.modelInfo(data: data)).validate()
        
        return request
            .publishDecodable(type: OKModelInfoResponse.self, decoder: decoder).value()
            .eraseToAnyPublisher()
    }
}
