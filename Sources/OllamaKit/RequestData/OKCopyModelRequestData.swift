//
//  OKCopyModelRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that encapsulates the necessary data to request a model copy operation in the Ollama API.
public struct OKCopyModelRequestData: Encodable {
    /// A string representing the identifier of the source model to be copied.
    public let source: String
    
    /// A string indicating the identifier for the destination or the new copy of the model.
    public let destination: String
    
    public init(source: String, destination: String) {
        self.source = source
        self.destination = destination
    }
}
