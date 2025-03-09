//
//  OllamaKit+Embeddings.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Foundation

extension OllamaKit {
    /// Asynchronously generates embeddings from a specific model from the Ollama API.
    ///
    /// This method accepts ``OKEmbeddingsRequestData`` and returns an ``OKEmbeddingsResponse`` containing embeddings from the requested model.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let requestData = OKEmbeddingsRequestData(/* parameters */)
    /// let embeddings = try await ollamaKit.embeddings(data: requestData)
    /// ```
    ///
    /// - Parameter data: The ``OKEmbeddingsRequestData`` used to query the API for generating specific model embeddings.
    /// - Returns: An ``OKEmbeddingsResponse`` containing the embeddings from the model.
    /// - Throws: An error if the request fails or the response can't be decoded.
    public func embeddings(data: OKEmbeddingsRequestData) async throws -> OKEmbeddingsResponse {
        let request = try OKRouter.embeddings(data: data).asURLRequest(with: baseURL)
        
        return try await OKHTTPClient.shared.send(request: request, with: OKEmbeddingsResponse.self)
    }
}
