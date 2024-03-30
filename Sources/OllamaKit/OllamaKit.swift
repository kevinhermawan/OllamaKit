//
//  OllamaKit.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// Provides a streamlined way to access the Ollama API, encapsulating the complexities of network communication and data processing.
public struct OllamaKit {
    var router: OKRouter.Type
    var decoder: JSONDecoder = .default
    
    /// Initializes a new instance of `OllamaKit` with the default base URL for the Ollama API.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// ```
    public init() {
        let router = OKRouter.self
        router.baseURL = URL(string: "http://localhost:11434")!
        
        self.router = router
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
        let router = OKRouter.self
        router.baseURL = baseURL
        
        self.router = router
    }
}
