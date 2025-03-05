//
//  OllamaKit+CopyModel.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Foundation

extension OllamaKit {
    /// Asynchronously requests the Ollama API to copy a model.
    ///
    /// This method sends a request to the Ollama API to copy a model based on the provided ``OKCopyModelRequestData``.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKCopyModelRequestData(/* parameters */)
    /// try await ollamaKit.copyModel(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKCopyModelRequestData`` containing the details needed to copy the model.
    /// - Throws: An error if the request to copy the model fails.
    public func copyModel(data: OKCopyModelRequestData) async throws -> Void {
        let request = try OKRouter.copyModel(data: data).asURLRequest(with: baseURL)

        try await OKHTTPClient.shared.send(request: request)
    }
}

#if canImport(Combine)
import Combine

extension OllamaKit {
    /// Requests the Ollama API to copy a model, returning the result as a Combine publisher.
    ///
    /// This method provides a reactive approach to request a model copy operation. It accepts ``OKCopyModelRequestData`` and returns a Combine publisher that completes when the copy operation is finished.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKCopyModelRequestData(/* parameters */)
    ///
    /// ollamaKit.copyModel(data: requestData)
    ///     .sink(receiveCompletion: { completion in
    ///         // Handle completion
    ///     }, receiveValue: {
    ///         // Handle successful completion of the copy operation
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Parameter data: The ``OKCopyModelRequestData`` used to request the model copy.
    /// - Returns: A `AnyPublisher<Void, Error>` that completes when the copy operation is done.
    public func copyModel(data: OKCopyModelRequestData) -> AnyPublisher<Void, Error> {
        do {
            let request = try OKRouter.copyModel(data: data).asURLRequest(with: baseURL)
            
            return OKHTTPClient.shared.send(request: request)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
#endif
