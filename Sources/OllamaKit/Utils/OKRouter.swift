//
//  OKRouter.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Foundation

internal enum OKRouter {

    
    case root
    case models
    case modelInfo(data: OKModelInfoRequestData)
    case generate(data: OKGenerateRequestData)
    case chat(data: OKChatRequestData)
    case copyModel(data: OKCopyModelRequestData)
    case deleteModel(data: OKDeleteModelRequestData)
    case embeddings(data: OKEmbeddingsRequestData)
    
    internal var path: String {
        switch self {
        case .root:
            return "/"
        case .models:
            return "/api/tags"
        case .modelInfo:
            return "/api/show"
        case .generate:
            return "/api/generate"
        case .chat:
            return "/api/chat"
        case .copyModel:
            return "/api/copy"
        case .deleteModel:
            return "/api/delete"
        case .embeddings:
            return "/api/embeddings"
        }
    }
    
    internal var method: String {
        switch self {
        case .root:
            return "HEAD"
        case .models:
            return "GET"
        case .modelInfo:
            return "POST"
        case .generate:
            return "POST"
        case .chat:
            return "POST"
        case .copyModel:
            return "POST"
        case .deleteModel:
            return "DELETE"
        case .embeddings:
            return "POST"
        }
    }
    
    internal var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}

extension OKRouter {
    func asURLRequest(baseURL: URL) throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .modelInfo(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        case .generate(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        case .chat(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        case .copyModel(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        case .deleteModel(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        case .embeddings(let data):
            request.httpBody = try JSONEncoder.default.encode(data)
        default:
            break
        }
        
        return request
    }
}
