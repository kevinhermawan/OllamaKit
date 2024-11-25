//
//  OKModelInfoResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that represents the response containing information about a specific model from the Ollama API.
public struct OKModelInfoResponse: Decodable, Sendable {
    /// A string detailing the licensing information for the model.
    public let license: String
    
    /// A string representing the template used by the model.
    public let template: String
    
    /// A string containing the path or identifier of the model file.
    public let modelfile: String
    
    /// A string detailing the parameters or settings of the model.
    public let parameters: String
}
