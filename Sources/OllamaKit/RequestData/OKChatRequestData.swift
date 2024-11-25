//
//  OKChatRequestData.swift
//
//
//  Created by Augustinas Malinauskas on 12/12/2023.
//

import Foundation

/// A structure that encapsulates data for chat requests to the Ollama API.
public struct OKChatRequestData: Sendable {
    private let stream: Bool
    
    /// A string representing the model identifier to be used for the chat session.
    public let model: String
    
    /// An array of ``Message`` instances representing the content to be sent to the Ollama API.
    public let messages: [Message]
    
    /// An optional array of ``OKJSONValue`` representing the tools available for tool calling in the chat.
    public let tools: [OKJSONValue]?
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the chat request.
    public var options: OKCompletionOptions?
    
    public init(model: String, messages: [Message], tools: [OKJSONValue]? = nil) {
        self.stream = tools == nil
        self.model = model
        self.messages = messages
        self.tools = tools
    }
    
    /// A structure that represents a single message in the chat request.
    public struct Message: Encodable, Sendable {
        /// A ``Role`` value indicating the sender of the message (system, assistant, user).
        public let role: Role
        
        /// A string containing the message's content.
        public let content: String
        
        /// An optional array of base64-encoded images.
        public let images: [String]?
        
        public init(role: Role, content: String, images: [String]? = nil) {
            self.role = role
            self.content = content
            self.images = images
        }
        
        /// An enumeration that represents the role of the message sender.
        public enum Role: String, Encodable, Sendable {
            /// Indicates the message is from the system.
            case system
            
            /// Indicates the message is from the assistant.
            case assistant
            
            /// Indicates the message is from the user.
            case user
        }
    }
}

extension OKChatRequestData: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stream, forKey: .stream)
        try container.encode(model, forKey: .model)
        try container.encode(messages, forKey: .messages)
        try container.encodeIfPresent(tools, forKey: .tools)
        
        if let options {
            try options.encode(to: encoder)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case stream, model, messages, tools
    }
}
