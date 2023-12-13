//
//  OKRouter.swift
//
//
//  Created by Kevin Hermawan on 10/11/23.
//

import Alamofire
import Foundation

internal enum OKRouter {
    static var baseURL = URL(string: "http://localhost:11434")!
    
    case root
    case models
    case modelInfo(data: OKModelInfoRequestData)
    case generate(data: OKGenerateRequestData)
    case chat(data: OkChatRequestData)
    case copyModel(data: OKCopyModelRequestData)
    case deleteModel(data: OKDeleteModelRequestData)
    
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
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .root:
            return .head
        case .models:
            return .get
        case .modelInfo:
            return .post
        case .generate:
            return .post
        case .chat:
            return .post
        case .copyModel:
            return .post
        case .deleteModel:
            return .delete
        }
    }
    
    internal var headers: HTTPHeaders {
        ["Content-Type": "application/json"]
    }
}

extension OKRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = OKRouter.baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        
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
        default:
            break
        }
        
        return request
    }
}
