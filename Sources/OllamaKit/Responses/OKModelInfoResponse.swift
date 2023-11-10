//
//  OKModelInfoResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure encapsulating detailed information about a specific model from the Ollama API.
///
/// Includes the model's license, template, modelfile, and operational parameters.
public struct OKModelInfoResponse: Decodable {
    public let license: String
    public let template: String
    public let modelfile: String
    public let parameters: String
}
