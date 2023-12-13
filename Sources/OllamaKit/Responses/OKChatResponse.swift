//
//  File.swift
//  
//
//  Created by Augustinas Malinauskas on 12/12/2023.
//

import Foundation

/// A structure representing the response from a chat request to the Ollama API.
///
/// Contains details of the generation process, including the model used, response content, and various performance metrics.
public struct OKChatResponse: Decodable {
    public let model: String
    public let createdAt: Date
    public let message: Message?
    public let done: Bool
    public let totalDuration: Int?
    public let loadDuration: Int?
    public let promptEvalCount: Int?
    public let promptEvalDuration: Int?
    public let evalCount: Int?
    public let evalDuration: Int?
    
    public struct Message: Decodable {
        public var role: String
        public var content: String
    }
}
