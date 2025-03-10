//
//  OllamaKit+Reachable.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Foundation

extension OllamaKit {
    /// Asynchronously checks if the Ollama API is reachable.
    ///
    /// This method attempts to make a network request to the Ollama API. It returns `true` if the request is successful, indicating that the API is reachable. Otherwise, it returns `false`.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let isReachable = await ollamaKit.reachable()
    /// ```
    ///
    /// - Returns: `true` if the Ollama API is reachable, `false` otherwise.
    public func reachable() async -> Bool {
        do {
            let request = try OKRouter.root.asURLRequest(with: baseURL)
            try await OKHTTPClient.shared.send(request: request)
            
            return true
        } catch {
            return false
        }
    }
}
