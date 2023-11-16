//
//  ViewModel.swift
//  Playground
//
//  Created by Kevin Hermawan on 16/11/23.
//

import Foundation
import OllamaKit

@Observable
final class ViewModel {
    var ollamaKit: OllamaKit
    
    var isReachable: Bool = false
    var models: [OKModelResponse.Model] = []
    
    init(ollamaKit: OllamaKit) {
        self.ollamaKit = ollamaKit
    }
    
    func setOK(with url: URL) {
        ollamaKit = OllamaKit(baseURL: url)
    }
    
    func isReachable() async {
        isReachable = await ollamaKit.reachable()
    }
    
    func fetchModels() async {
        do {
            let response = try await ollamaKit.models()
            models = response.models
        } catch {
            fatalError("Error fetchModels: \(error)")
        }
    }
    
    func copyModel(of model: OKModelResponse.Model, to name: String) async {
        let data = OKCopyModelRequestData(source: model.name, destination: name)
        
        do {
            try await ollamaKit.copyModel(data: data)
            await fetchModels()
        } catch {
            fatalError("Error copyModel: \(error)")
        }
    }
    
    func deleteModel(of model: OKModelResponse.Model) async {
        let data = OKDeleteModelRequestData(name: model.name)
        
        do {
            try await ollamaKit.deleteModel(data: data)
            await fetchModels()
        } catch {
            fatalError("Error deleteModel: \(error)")
        }
    }
}
