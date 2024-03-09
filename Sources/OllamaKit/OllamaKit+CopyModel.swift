//
//  OllamaKit+CopyModel.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously requests the Ollama API to copy a model.
    ///
    /// This method sends a request to the Ollama API to copy a model based on the provided ``OKCopyModelRequestData``.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    /// let requestData = OKCopyModelRequestData(/* parameters */)
    /// try await ollamaKit.copyModel(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKCopyModelRequestData`` containing the details needed to copy the model.
    /// - Throws: An error if the request to copy the model fails.
    public func copyModel(data: OKCopyModelRequestData) async throws {
        let request = AF.request(router.copyModel(data: data)).validate()
        _ = try await request.serializingData().response.result.get()
    }
    
    /// Requests the Ollama API to copy a model, returning the result as a Combine publisher.
    ///
    /// This method provides a reactive approach to request a model copy operation. It accepts ``OKCopyModelRequestData`` and returns a Combine publisher that completes when the copy operation is finished.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
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
        let request = AF.request(router.copyModel(data: data)).validate()
        
        return request.publishData()
            .tryMap { _ in Void() }
            .eraseToAnyPublisher()
    }
}
