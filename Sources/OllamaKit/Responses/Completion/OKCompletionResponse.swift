//
//  OKCompletionResponse.swift
//
//
//  Created by Kevin Hermawan on 02/01/24.
//

import Foundation

protocol OKCompletionResponse: Decodable {
    var model: String { get }
    var createdAt: Date { get }
    var done: Bool { get }
    
    var totalDuration: Int? { get }
    var loadDuration: Int? { get }
    var promptEvalCount: Int? { get }
    var promptEvalDuration: Int? { get }
    var evalCount: Int? { get }
    var evalDuration: Int? { get }
}
