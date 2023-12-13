//
//  OKGenerateRequestData.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

/// A structure representing the data required to generate responses from the Ollama API.
///
/// It includes the model name, prompt, and other optional parameters that tailor the generation process, such as format and context.
public struct OKGenerateRequestData: Encodable {
    private let stream: Bool

    public let model: String
    public let prompt: String
    public var format: Format?
    public var system: String?
    public var template: String?
    public var options: Options?
    public var context: [Int]?
    public var raw: Bool?
    
    public init(model: String, prompt: String) {
        self.stream = true
        self.model = model
        self.prompt = prompt
    }
}
