//
//  OKGenerateResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing the response from a generate request to the Ollama API.
///
/// Contains details of the generation process, including the model used, response content, and various performance metrics.
public struct OKGenerateResponse: Decodable {
    public let model: String
    public let createdAt: Date
    public let response: String
    public let done: Bool
    public let context: [Int]?
    public let totalDuration: Int?
    public let loadDuration: Int?
    public let promptEvalCount: Int?
    public let promptEvalDuration: Int?
    public let evalCount: Int?
    public let evalDuration: Int?
}
