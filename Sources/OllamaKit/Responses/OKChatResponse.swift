//
//  OKChatResponse.swift
//
//
//  Created by Augustinas Malinauskas on 12/12/2023.
//

import Foundation

/// A structure that represents the response to a chat request from the Ollama API.
public struct OKChatResponse: OKCompletionResponse, Decodable {
    /// The identifier of the model that processed the request.
    public let model: String
    
    /// The date and time when the response was created.
    public let createdAt: Date
    
    /// An optional ``Message`` instance representing the content of the response.
    /// Contains the main message data, including the role of the sender and the content.
    public let message: Message?
    
    /// A boolean indicating whether the chat session is complete.
    public let done: Bool
    
    /// An optional string providing the reason for the completion of the chat session.
    public let doneReason: String?
    
    /// An optional integer representing the total duration of processing the request, in nanoseconds.
    public let totalDuration: Int?
    
    /// An optional integer representing the time taken to load the model, in nanoseconds.
    public let loadDuration: Int?
    
    /// An optional integer indicating the number of tokens in the prompt that were evaluated.
    public let promptEvalCount: Int?
    
    /// An optional integer representing the duration of prompt evaluations, in nanoseconds.
    public let promptEvalDuration: Int?
    
    /// An optional integer indicating the number of tokens generated in the response.
    public let evalCount: Int?
    
    /// An optional integer representing the duration of all evaluations, in nanoseconds.
    public let evalDuration: Int?
    
    /// A structure that represents a single response message.
    public struct Message: Decodable, Sendable {
        /// The role of the message sender (system, assistant, user).
        public var role: Role
        
        /// The content of the message.
        public var content: String
        
        /// An optional array of ``ToolCall`` instances representing any tools invoked in the response.
        public var toolCalls: [ToolCall]?
        
        /// An enumeration representing the role of the message sender.
        public enum Role: RawRepresentable, Decodable, Sendable {

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
        
        /// A structure that represents a tool call in the response.
        public struct ToolCall: Decodable, Sendable {
            /// An optional ``Function`` structure representing the details of the tool call.
            public let function: Function?
            
            /// A structure that represents the details of a tool call.
            public struct Function: Decodable, Sendable {
                /// The name of the tool being called.
                public let name: String?
                
                /// An optional ``OKJSONValue`` representing the arguments passed to the tool.
                public let arguments: OKJSONValue?
            }
        }
    }
}
