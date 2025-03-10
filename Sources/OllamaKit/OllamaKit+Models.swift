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
