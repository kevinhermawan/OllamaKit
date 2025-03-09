//
//  OllamaKit+DeleteModel.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

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
        let request = try OKRouter.deleteModel(data: data).asURLRequest(with: baseURL)
        
        try await OKHTTPClient.shared.send(request: request)
    }
}
