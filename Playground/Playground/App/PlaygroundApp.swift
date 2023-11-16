//
//  PlaygroundApp.swift
//  Playground
//
//  Created by Kevin Hermawan on 16/11/23.
//

import OllamaKit
import SwiftUI

@main
struct PlaygroundApp: App {
    @State private var viewModel: ViewModel
    
    init() {
        let url = URL(string: "http://localhost:11434")!
        let ollamaKit = OllamaKit(baseURL: url)
        let viewModel = ViewModel(ollamaKit: ollamaKit)
        
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
