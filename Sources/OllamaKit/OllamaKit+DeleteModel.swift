//
//  OllamaKit+DeleteModel.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Alamofire
import Combine
import Foundation

extension OllamaKit {
    /// Asynchronously requests the Ollama API to delete a specific model.
    ///
    /// This method sends a request to the Ollama API to delete a model based on the provided ``OKDeleteModelRequestData``.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKDeleteModelRequestData(/* parameters */)
    /// try await ollamaKit.deleteModel(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKDeleteModelRequestData`` containing the details needed to delete the model.
    /// - Throws: An error if the request to delete the model fails.
    public func deleteModel(data: OKDeleteModelRequestData) async throws -> Void {
        let request = AF.request(router.deleteModel(data: data)).validate()
        _ = try await request.serializingData().response.result.get()
    }
    
    /// Requests the Ollama API to delete a specific model, returning the result as a Combine publisher.
    ///
    /// This method provides a reactive approach to request a model deletion operation. It accepts ``OKDeleteModelRequestData`` and returns a Combine publisher that completes when the deletion operation is finished.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKDeleteModelRequestData(/* parameters */)
    ///
    /// ollamaKit.deleteModel(data: requestData)
    ///     .sink(receiveCompletion: { completion in
    ///         // Handle completion
    ///     }, receiveValue: {
    ///         // Handle successful completion of the deletion operation
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Parameter data: The ``OKDeleteModelRequestData`` used to request the model deletion.
    /// - Returns: A `AnyPublisher<Void, Error>` that completes when the deletion operation is done.
    public func deleteModel(data: OKDeleteModelRequestData) -> AnyPublisher<Void, Error> {
        let request = AF.request(router.deleteModel(data: data)).validate()
        
        return request.publishData()
            .tryMap { _ in Void() }
            .eraseToAnyPublisher()
    }
}
