//
//  OllamaKit+ModelInfo.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

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
        let request = try OKRouter.modelInfo(data: data).asURLRequest(with: baseURL)

        return try await OKHTTPClient.shared.send(request: request, with: OKModelInfoResponse.self)
    }
}

#if canImport(Combine)
import Combine

extension OllamaKit {
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
    /// - Returns: A `AnyPublisher<OKModelInfoResponse, Error>` that emits detailed information about the model.
    public func modelInfo(data: OKModelInfoRequestData) -> AnyPublisher<OKModelInfoResponse, Error> {
        do {
            let request = try OKRouter.modelInfo(data: data).asURLRequest(with: baseURL)
            
            return OKHTTPClient.shared.send(request: request, with: OKModelInfoResponse.self)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
#endif
