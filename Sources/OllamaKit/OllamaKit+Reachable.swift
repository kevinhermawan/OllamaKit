//
//  OllamaKit+Reachable.swift
//
//
//  Created by Kevin Hermawan on 01/01/24.
//

import Combine
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
    
    /// Checks if the Ollama API is reachable, returning the result as a Combine publisher.
    ///
    /// This method performs a network request to the Ollama API and returns a Combine publisher that emits `true` if the API is reachable. In case of any errors, it emits `false`.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    ///
    /// ollamaKit.reachable()
    ///     .sink(receiveValue: { isReachable in
    ///         // Handle the reachability status
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    ///
    /// - Returns: A `AnyPublisher<Bool, Never>` that emits `true` if the API is reachable, `false` otherwise.
    public func reachable() -> AnyPublisher<Bool, Never> {
        do {
            let request = try OKRouter.root.asURLRequest(with: baseURL)
            
            return OKHTTPClient.shared.send(request: request)
                .map { _ in true }
                .replaceError(with: false)
                .eraseToAnyPublisher()
        } catch {
            return Just(false).eraseToAnyPublisher()
        }
    }
}
