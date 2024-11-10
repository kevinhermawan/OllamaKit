//
//  OKGenerateResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that represents the response to a content generation request from the Ollama API.
public struct OKGenerateResponse: OKCompletionResponse, Decodable, Sendable {
    /// The identifier of the model used for generating the content.
    public let model: String
    
    /// The date and time when the response was generated.
    public let createdAt: Date
    
    /// A string containing the generated content. This field will be empty if the response was streamed; otherwise, it contains the full response.
    public let response: String
    
    /// An optional array of integers providing contextual information used during generation.
    public let context: [Int]?
    
    /// A boolean indicating whether the content generation process is complete.
    public let done: Bool
    
    /// An optional string providing the reason for the completion of the generation process.
    public let doneReason: String?
    
    /// An optional integer representing the total time spent generating the response, in nanoseconds.
    public let totalDuration: Int?
    
    /// An optional integer representing the time spent loading the model, in nanoseconds.
    public let loadDuration: Int?
    
    /// An optional integer indicating the number of tokens in the prompt that were evaluated.
    public let promptEvalCount: Int?
    
    /// An optional integer representing the time spent evaluating the prompt, in nanoseconds.
    public let promptEvalDuration: Int?
    
    /// An optional integer indicating the number of tokens in the generated response.
    public let evalCount: Int?
    
    /// An optional integer representing the time spent generating the response, in nanoseconds.
    public let evalDuration: Int?
}
