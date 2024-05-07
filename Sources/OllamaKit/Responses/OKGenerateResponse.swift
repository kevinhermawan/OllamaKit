//
//  OKGenerateResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that represents the response to a content generation request from the Ollama API.
public struct OKGenerateResponse: OKCompletionResponse, Decodable {
    /// A string representing the identifier of the model used for generation.
    public let model: String
    
    /// A `Date` indicating when the response was generated.
    public let createdAt: Date
    
    /// A string containing the generated content.
    public let response: String
    
    /// An optional array of integers representing contextual information used in the generation.
    public let context: [Int]?
    
    /// A boolean indicating whether the generation process is complete.
    public let done: Bool
    
    /// An optional integer representing the total duration of processing the request.
    public let totalDuration: Int?
    
    /// An optional integer indicating the duration of loading the model.
    public let loadDuration: Int?
    
    /// An optional integer specifying the number of evaluations performed on the prompt.
    public let promptEvalCount: Int?
    
    /// An optional integer indicating the duration of prompt evaluations.
    public let promptEvalDuration: Int?
    
    /// An optional integer representing the total number of evaluations performed.
    public let evalCount: Int?
    
    /// An optional integer indicating the duration of all evaluations.
    public let evalDuration: Int?
}
