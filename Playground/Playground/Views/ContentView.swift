//
//  ContentView.swift
//  Playground
//
//  Created by Kevin Hermawan on 16/11/23.
//

import SwiftUI
import OllamaKit

struct ContentView: View {
    @Environment(ViewModel.self) private var viewModel
        
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Models")) {
                    ForEach(viewModel.models, id: \.name) { model in
                        Text(model.name)
                            .contextMenu {
                                Button(action: { copyAction(model: model) }) {
                                    Label("Copy", systemImage: "doc.on.doc")
                                }
                                
                                Button(role: .destructive, action: { deleteAction(model: model) }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Playground")
            .task {
                await viewModel.isReachable()
                
                if viewModel.isReachable {
                    await viewModel.fetchModels()
                }
            }
        }
    }
    
    func copyAction(model: OKModelResponse.Model) {
        Task {
            await viewModel.copyModel(of: model, to: "\(model.name)-copy")
        }
    }
    
    func deleteAction(model: OKModelResponse.Model) {
        Task {
            await viewModel.deleteModel(of: model)
        }
    }
}

#Preview {
    let url = URL(string: "http://localhost:11434")!
    let ollamaKit = OllamaKit(baseURL: url)
    let viewModel = ViewModel(ollamaKit: ollamaKit)
    
    return ContentView()
        .environment(viewModel)
}
