//
//  AppView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import SwiftUI

struct AppView: View {
    @Environment(ViewModel.self) private var viewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Reachable")
                        .badge(viewModel.isReachable ? "Yes" : "No")
                }
                
                Section("Models") {
                    NavigationLink("Model List") {
                        ModelListView()
                    }
                    
                    NavigationLink("Model Info") {
                        ModelInfoView()
                    }
                    
                    NavigationLink("Copy Model") {
                        CopyModelView()
                    }
                    
                    NavigationLink("Delete Model") {
                        DeleteModelView()
                    }
                }
                
                Section("Generation") {
                    NavigationLink("Chat") {
                        ChatView()
                    }
                    
                    NavigationLink("Chat with Tools") {
                        ChatWithToolsView()
                    }
                    
                    NavigationLink("Generate") {
                        GenerateView()
                    }
                }
                
                Section("Embeddings") {
                    NavigationLink("Embeddings") {
                        EmbeddingsView()
                    }
                }
            }
            .navigationTitle("OKPlayground")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.reachable()
                await viewModel.fetchModels()
            }
        }
    }
}
