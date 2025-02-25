//
//  OllamaKit.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// Provides a streamlined way to access the Ollama API, encapsulating the complexities of network communication and data processing.
public struct OllamaKit: Sendable {
    var router: OKRouter.Type
    var decoder: JSONDecoder = .default
    var baseURL: URL
    var bearerToken: String?

    /// Initializes a new instance of `OllamaKit` with the default base URL and no bearer token for the Ollama API.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// ```
    public init() {
        self.init(baseURL: URL(string: "http://localhost:11434")!, bearerToken: nil)
    }
    
    /// Initializes a new instance of `OllamaKit` with a custom base URL for the Ollama API.
    ///
    /// ```swift
    /// let customBaseURL = URL(string: "https://api.customollama.com")!
    /// let ollamaKit = OllamaKit(baseURL: customBaseURL)
    /// ```
    ///
    /// - Parameter baseURL: The base URL to use for API requests.
    public init(baseURL: URL) {
        self.init(baseURL: baseURL, bearerToken: nil)
    }
    
    /// Initializes a new instance of `OllamaKit` with a bearer token for the Ollama API.
    ///
    /// ```swift
    /// let bearerToken = "super-sected-token"
    /// let ollamaKit = OllamaKit(bearerToken: bearerToken)
    /// ```
    ///
    /// - Parameter bearerToken: The bearer token to use for API requests.
    public init(bearerToken: String) {
        self.init(baseURL: URL(string: "http://localhost:11434")!, bearerToken: bearerToken)
    }
    
    /// Initializes a new instance of `OllamaKit` with a custom base URL and bearer token for the Ollama API.
    ///
    /// ```swift
    /// let bearerToken = "super-sected-token"
    /// let customBaseURL = URL(string: "https://api.customollama.com")!
    /// let ollamaKit = OllamaKit(baseURL: customBaseURL, bearerToken: bearerToken)
    /// ```
    ///
    /// - Parameter baseURL: The base URL to use for API requests.
    /// - Parameter bearerToken: The bearer token to use for API requests. 
    public init(baseURL: URL, bearerToken: String?) {
        let router = OKRouter.self
        self.router = router
        self.baseURL = baseURL
        self.bearerToken = bearerToken
    }
}
