//
//  OKDeleteModelRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that encapsulates the necessary data to request a model deletion in the Ollama API.
public struct OKDeleteModelRequestData: Encodable {
    /// A string representing the identifier of the model to be deleted.
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
