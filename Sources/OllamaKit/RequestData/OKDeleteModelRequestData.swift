//
//  OKDeleteModelRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing the request data for deleting a model through the Ollama API.
///
/// This structure encapsulates the name of the model to be deleted, providing a straightforward way to specify which model should be removed.
public struct OKDeleteModelRequestData: Encodable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
