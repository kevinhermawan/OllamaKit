//
//  OKPullModelResponse.swift
//
//
//  Created by Lukas Pistrol on 25.11.24.
//

import Foundation

/// The response model for pulling a new model from the ollama library.
public struct OKPullModelResponse: Decodable {
    /// The current status.
    public let status: String

    /// The digest hash of the current file.
    public let digest: String?

    /// The size of the current file.
    public let total: Int?

    /// The number of bytes that have been completed.
    public let completed: Int?
}
