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

    /// Optional ``OKJSONValue`` representing the JSON schema for the response.
    /// Be sure to also include "return as JSON" in your prompt
    public let format: OKJSONValue?

    /// Optional ``OKCompletionOptions`` providing additional configuration for the chat request.
    public var options: OKCompletionOptions?
    

    public init(
        model: String,
        messages: [Message],
        tools: [OKJSONValue]? = nil,
        format: OKJSONValue? = nil,
        options: OKCompletionOptions? = nil
    ) {
        self.stream = tools == nil
        self.model = model
        self.messages = messages
        self.tools = tools
        self.format = format
        self.options = options
    }
    
    public init(
        model: String,
        messages: [Message],
        tools: [OKJSONValue]? = nil,
        format: OKJSONValue? = nil,
        with configureOptions: @Sendable (inout OKCompletionOptions) -> Void
    ) {
        self.stream = tools == nil
        self.model = model
        self.messages = messages
        self.tools = tools
        var options = OKCompletionOptions()
        configureOptions(&options)
        self.format = format
        self.options = options        
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
        
        /// An enumeration representing the role of the message sender.
        public enum Role: RawRepresentable, Encodable, Sendable {
            
            /// The message is from the system.
            case system
            
            /// The message is from the assistant.
            case assistant
            
            /// The message is from the user.
            case user
            
            /// A custom role with a specified name.
            case custom(String)
            
            // Initializer for RawRepresentable conformance
            public init?(rawValue: String) {
                switch rawValue {
                case "system":
                    self = .system
                case "assistant":
                    self = .assistant
                case "user":
                    self = .user
                default:
                    self = .custom(rawValue)
                }
            }
            
            // Computed property to get the raw value as a string.
            public var rawValue: String {
                switch self {
                case .system:
                    return "system"
                case .assistant:
                    return "assistant"
                case .user:
                    return "user"
                case .custom(let value):
                    return value
                }
            }
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
        try container.encodeIfPresent(format, forKey: .format)
        if let options {
            try options.encode(to: encoder)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case stream, model, messages, tools, format
    }
}

extension OKChatRequestData.Message {
    
    public static func system(_ content: String, images: [String]? = nil) -> OKChatRequestData.Message {
        .init(role: .system, content: content, images: images)
    }
    
    public static func user(_ content: String, images: [String]? = nil) -> OKChatRequestData.Message {
        .init(role: .user, content: content, images: images)
    }
    
    public static func assistant(_ content: String, images: [String]? = nil) -> OKChatRequestData.Message {
        .init(role: .assistant, content: content, images: images)
    }
    
    public static func custom(name: String, _ content: String, images: [String]? = nil) -> OKChatRequestData.Message {
        .init(role: .custom(name), content: content, images: images)
    }
}
