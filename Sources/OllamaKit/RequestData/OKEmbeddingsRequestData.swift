//
//  OKEmbeddingsRequestData.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Foundation

/// A structure that encapsulates the data required for generating embeddings using the Ollama API.
public struct OKEmbeddingsRequestData: Encodable, Sendable {
    /// A string representing the identifier of the model.
    public let model: String
    
    /// A string containing the initial input or prompt.
    public let prompt: String
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the generation request.
    public var options: OKCompletionOptions?
    
    /// Optionally control how long the model will stay loaded into memory following the request (default: 5m)
    public var keepAlive: String?
    
    public init(model: String, prompt: String, options: OKCompletionOptions? = nil, keepAlive: String? = nil) {
        self.model = model
        self.prompt = prompt
        self.options = options
        self.keepAlive = keepAlive
    }
    
    public init(
        model: String,
        prompt: String,
        with configureOptions: @Sendable (inout OKCompletionOptions) -> Void
    ) {
        self.model = model
        self.prompt = prompt
        var options = OKCompletionOptions()
        configureOptions(&options)
        self.options = options
    }
}
