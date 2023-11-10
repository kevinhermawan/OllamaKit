//
//  OKCopyModelRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing the request data for copying a model via the Ollama API.
///
/// This structure holds the information necessary to duplicate a model, including the source model's name and the desired destination name.
public struct OKCopyModelRequestData: Encodable {
    public let source: String
    public let destination: String
    
    public init(source: String, destination: String) {
        self.source = source
        self.destination = destination
    }
}
