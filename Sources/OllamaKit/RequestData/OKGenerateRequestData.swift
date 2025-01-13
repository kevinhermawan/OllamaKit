//
//  OKGenerateRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation
import JSONSchema

/// A structure that encapsulates the data required for generating responses using the Ollama API.
public struct OKGenerateRequestData: Sendable {
    private let stream: Bool
    
    /// A string representing the identifier of the model.
    public let model: String
    
    /// A string containing the initial input or prompt.
    public let prompt: String
    
    /// An optional array of base64-encoded images.
    public let images: [String]?

    /// Optional ``JSONSchema`` representing the JSON schema for the response.
    /// Be sure to also include "return as JSON" in your prompt
    public let format: JSONSchema?

    /// An optional string specifying the system message.
    public var system: String?
    
    /// An optional array of integers representing contextual information.
    public var context: [Int]?
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the generation request.
    public var options: OKCompletionOptions?
    
    public init(
        model: String,
        prompt: String,
        images: [String]? = nil,
        system: String? = nil,
        context: [Int]? = nil,
        format: JSONSchema? = nil,
        options: OKCompletionOptions? = nil
    ) {
        self.stream = true
        self.model = model
        self.prompt = prompt
        self.images = images
        self.system = system
        self.context = context
        self.format = format
        self.options = options
    }
    
    public init(
        model: String,
        prompt: String,
        images: [String]? = nil,
        format: JSONSchema? = nil,
        with configureOptions: @Sendable (inout OKCompletionOptions) -> Void
    ) {
        self.stream = true
        self.model = model
        self.prompt = prompt
        self.images = images
        var options = OKCompletionOptions()
        configureOptions(&options)
        self.options = options
        self.format = format
    }
}

extension OKGenerateRequestData: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stream, forKey: .stream)
        try container.encode(model, forKey: .model)
        try container.encode(prompt, forKey: .prompt)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encodeIfPresent(format, forKey: .format)
        try container.encodeIfPresent(system, forKey: .system)
        try container.encodeIfPresent(context, forKey: .context)
        
        if let options {
            try options.encode(to: encoder)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case stream, model, prompt, images, format, system, context
    }
}
