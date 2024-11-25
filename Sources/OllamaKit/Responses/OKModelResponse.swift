//
//  OKModelResponse.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure that represents the available models from the Ollama API.
public struct OKModelResponse: Decodable {
    /// An array of ``Model`` instances, each representing a specific model available in the Ollama API.
    public let models: [Model]
    
    /// A structure that details individual models.
    public struct Model: Decodable {
        /// A string representing the name of the model.
        public let name: String
        
        /// A string containing a digest or hash of the model, typically used for verification or identification.
        public let digest: String
        
        /// An integer indicating the size of the model, often in bytes.
        public let size: Int
        
        /// A `Date` representing the last modification date of the model.
        public let modifiedAt: Date

        /// The details about the model.
        public let details: ModelDetails

        /// A structure that represents the details of the model.
        public struct ModelDetails: Decodable {
            /// The format of the model. E.g. "gguf".
            public let format: String

            /// The family of the model. E.g. "llama".
            public let family: String

            /// The parameter size of the model. E.g. "8.0B".
            public let parameterSize: String

            /// The quantization level of the model. E.g. "Q4_0".
            public let quantizationLevel: String

            /// All the families of the model. E.g. ["llama", "phi3"].
            public let families: [String]?
        }
    }
}
