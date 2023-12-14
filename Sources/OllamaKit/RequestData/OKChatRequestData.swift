//
//  File.swift
//  
//
//  Created by Augustinas Malinauskas on 12/12/2023.
//

import Foundation

/// A structure representing the data required to generate responses from the Ollama API.
///
/// It includes the model name, prompt, and other optional parameters that tailor the generation process, such as format and context.
public struct OkChatRequestData: Encodable {
    private let stream: Bool

    public let model: String
    public let messages: [ChatMessage]
    public var format: Format?
    public var options: Options?
    public var template: String?

    public init(model: String, messages: [ChatMessage]) {
        self.stream = true
        self.model = model
        self.messages = messages
    }
}

public struct ChatMessage: Encodable {
    public var role: String
    public var content: String
    
    public init(role: String, content: String) {
        self.role = role
        self.content = content
    }
}

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
