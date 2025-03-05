//
//  OllamaKit+Models.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Foundation

extension OllamaKit {
    /// Asynchronously retrieves a list of available models from the Ollama API.
    ///
    /// This method returns an ``OKModelResponse`` containing the details of the available models.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let models = try await ollamaKit.models()
    /// ```
    ///
    /// - Returns: An ``OKModelResponse`` object listing the available models.
    /// - Throws: An error if the request fails or the response can't be decoded.
    public func models() async throws -> OKModelResponse {
        let request = try OKRouter.models.asURLRequest(with: baseURL)

        return try await OKHTTPClient.shared.send(request: request, with: OKModelResponse.self)
    }
}

#if canImport(Combine)
import Combine

extension OllamaKit {
    /// Retrieves a list of available models from the Ollama API as a Combine publisher.
    ///
    /// This method provides a reactive approach to fetch model data, returning a Combine publisher that emits an ``OKModelResponse`` with details of available models.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
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
    /// - Returns: A `AnyPublisher<OKModelResponse, Error>` that emits the list of available models.
    public func models() -> AnyPublisher<OKModelResponse, Error> {
        do {
            let request = try OKRouter.models.asURLRequest(with: baseURL)
            
            return OKHTTPClient.shared.send(request: request, with: OKModelResponse.self)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
#endif
