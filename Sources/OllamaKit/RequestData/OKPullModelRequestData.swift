//
//  OKPullModelRequestData.swift
//
//
//  Created by Lukas Pistrol on 25.11.24.
//

import Foundation

/// A structure that encapsulates the data necessary for pulling a new model from the ollama library using the Ollama API.
public struct OKPullModelRequestData: Encodable, Sendable {
    private let stream: Bool

    /// A string representing the identifier of the model for which information is requested.
    public let model: String

    public init(model: String) {
        self.stream = true
        self.model = model
    }
}

