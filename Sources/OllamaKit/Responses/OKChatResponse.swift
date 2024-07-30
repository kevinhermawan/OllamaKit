//
//  OKChatResponse.swift
//
//
//  Created by Augustinas Malinauskas on 12/12/2023.
//

import Foundation

/// A structure that represents the response to a chat request from the Ollama API.
public struct OKChatResponse: OKCompletionResponse, Decodable {
    /// A string representing the identifier of the model that processed the request.
    public let model: String
    
    /// A `Date` indicating when the response was created.
    public let createdAt: Date
    
    /// An optional `Message` instance representing the content of the response.
    public let message: Message?
    
    /// A boolean indicating whether the chat session is complete.
    public let done: Bool
    
    /// An optional string indicating the cause for the completion of the chat session.
    public let doneReason: String?
    
    /// An optional integer representing the total duration of processing the request.
    public let totalDuration: Int?
    
    /// An optional integer indicating the duration of loading the model.
    public let loadDuration: Int?
    
    /// An optional integer specifying the number of evaluations performed on the prompt.
    public let promptEvalCount: Int?
    
    /// An optional integer indicating the duration of prompt evaluations.
    public let promptEvalDuration: Int?
    
    ///  An optional integer representing the total number of evaluations performed.
    public let evalCount: Int?
    
    ///  An optional integer indicating the duration of all evaluations.
    public let evalDuration: Int?
    
    /// A  structure  that represents a single response message.
    public struct Message: Decodable {
        /// A ``Role`` value indicating the sender of the message (system, assistant, user).
        public var role: Role
        
        /// A string containing the message's content.
        public var content: String
        
        public var toolCalls: [ToolCall]?
        
        /// An enumeration that represents the role of the message sender.
        public enum Role: String, Decodable {
            /// Indicates the message is from the system.
            case system
            
            /// Indicates the message is from the assistant.
            case assistant
            
            /// Indicates the message is from the user.
            case user
        }
        
        /// A structure that represents a tool call in the response.
        public struct ToolCall: Decodable {
            /// An optional `Function` structure that represents the details of the tool call.
            public let function: Function?
            
            /// A structure that represents the details of a tool call.
            public struct Function: Decodable {
                /// The name of the tool being called.
                public let name: String?
                
                /// An optional `OKJSONValue` that represents the arguments passed to the tool.
                public let arguments: OKJSONValue?
            }
        }
    }
}
