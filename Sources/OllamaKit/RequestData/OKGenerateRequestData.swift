//
//  OKGenerateRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that encapsulates the data required for generating responses using the Ollama API.
public struct OKGenerateRequestData: Encodable {
    private let stream: Bool
    
    /// A string representing the identifier of the model.
    public let model: String
    
    /// A string containing the initial input or prompt.
    public let prompt: String
    
    /// /// An optional array of base64-encoded images.
    public let images: [String]
    
    /// An optional string specifying the system message.
    public var system: String?
    
    /// An optional array of integers representing contextual information.
    public var context: [Int]?
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the generation request.
    public var options: OKCompletionOptions?
    
    public init(model: String, prompt: String, images: [String] = []) {
        self.stream = true
        self.model = model
        self.prompt = prompt
        self.images = images
    }
}
