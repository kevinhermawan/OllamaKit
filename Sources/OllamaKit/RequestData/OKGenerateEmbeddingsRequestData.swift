//
//  OKGenerateEmbeddingsRequestData.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Foundation

/// A structure that encapsulates the data required for generating embeddings using the Ollama API.
public struct OKGenerateEmbeddingsRequestData: Encodable {
    /// A string representing the identifier of the model.
    public let model: String
    
    /// A string containing the initial input or prompt.
    public let prompt: String
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the generation request.
    public var options: OKCompletionOptions?
    
    /// Optionally control how long the model will stay loaded into memory following the request (default: 5m)
    public var keepAlive: String?
    
    public init(model: String, prompt: String) {
        self.model = model
        self.prompt = prompt
    }
}
