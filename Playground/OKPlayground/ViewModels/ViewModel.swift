//
//  ViewModel.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 09/06/24.
//

import Foundation
import OllamaKit

@Observable
final class ViewModel {
    var ollamaKit = OllamaKit()
    
    var isReachable = false
    var models = [String]()
    
    func reachable() async {
        self.isReachable = await ollamaKit.reachable()
    }
    
    func fetchModels() async {
        let response = try? await ollamaKit.models()
        guard let models = response?.models.map({ $0.name }) else { return }
        
        self.models = models
    }
}
