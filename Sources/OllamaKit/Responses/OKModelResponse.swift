//
//  OKModelResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing a list of models available through the Ollama API.
///
/// Contains an array of `OKModelResponse.Model` structures, each detailing a specific model's name, digest, size, and last modification date.
public struct OKModelResponse: Decodable {
    public let models: [Model]
    
    public struct Model: Decodable {
        public let name: String
        public let digest: String
        public let size: Int
        public let modifiedAt: Date
    }
}
