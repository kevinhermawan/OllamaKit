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
