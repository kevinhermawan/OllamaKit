//
//  OKModelInfoRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing the request data for fetching model information from the Ollama API.
///
/// This structure is used to specify the name of the model for which detailed information is requested.
public struct OKModelInfoRequestData: Encodable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
