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
    
    public enum Format: String, Encodable {
        case json
    }
    
    public struct Options: Encodable {
        public var mirostat: Int?
        public var mirostatEta: Double?
        public var mirostatTau: Double?
        public var numCtx: Int?
        public var numGqa: Int?
        public var numGpu: Int?
        public var numThread: Int?
        public var repeatLastN: Int?
        public var repeatPenalty: Int?
        public var temperature: Double?
        public var seed: Int?
        public var stop: String?
        public var tfsZ: Double?
        public var numPredict: Int?
        public var topK: Int?
        public var topP: Double?
    }
    
    public init(model: String, prompt: String) {
        self.stream = true
        self.model = model
        self.prompt = prompt
    }
}
