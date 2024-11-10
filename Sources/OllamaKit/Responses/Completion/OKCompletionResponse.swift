//
//  OKCompletionResponse.swift
//
//
//  Created by Kevin Hermawan on 02/01/24.
//

import Foundation

/// A protocol that defines the response structure for a completion request in the Ollama API.
protocol OKCompletionResponse: Decodable, Sendable {
    /// The identifier of the model used for generating the response.
    var model: String { get }
    
    /// The date and time when the response was created.
    var createdAt: Date { get }
    
    /// A boolean indicating whether the completion process is done.
    var done: Bool { get }
    
    /// An optional string providing the reason why the process was completed.
    var doneReason: String? { get }
    
    /// An optional integer representing the total time spent generating the response, in nanoseconds.
    var totalDuration: Int? { get }
    
    /// An optional integer representing the time spent loading the model, in nanoseconds.
    var loadDuration: Int? { get }
    
    /// An optional integer indicating the number of tokens in the prompt that were evaluated.
    var promptEvalCount: Int? { get }
    
    /// An optional integer representing the time spent evaluating the prompt, in nanoseconds.
    var promptEvalDuration: Int? { get }
    
    /// An optional integer indicating the number of tokens in the generated response.
    var evalCount: Int? { get }
    
    /// An optional integer representing the time spent generating the response, in nanoseconds.
    var evalDuration: Int? { get }
}
