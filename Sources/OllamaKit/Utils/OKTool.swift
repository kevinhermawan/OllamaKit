//
//  OKTool.swift
//  OllamaKit
//
//  Created by Norikazu Muramoto on 2025/01/11.
//

import Foundation

/// Represents a tool that can be used in the Ollama API chat.
public struct OKTool: Encodable, Sendable {
    /// The type of the tool (e.g., "function").
    public let type: String
    
    /// The function details associated with the tool.
    public let function: OKFunction
    
    public init(type: String, function: OKFunction) {
        self.type = type
        self.function = function
    }
    
    /// Convenience method for creating a tool with type "function".
    public static func function(_ function: OKFunction) -> OKTool {
        return OKTool(type: "function", function: function)
    }
}

/// Represents a function used as a tool in the Ollama API chat.
public struct OKFunction: Encodable, Sendable {
    /// The name of the function.
    public let name: String
    
    /// A description of what the function does.
    public let description: String
    
    /// Parameters required by the function, defined as a JSON schema.
    public let parameters: OKJSONValue
    
    public init(name: String, description: String, parameters: OKJSONValue) {
        self.name = name
        self.description = description
        self.parameters = parameters
    }
}

