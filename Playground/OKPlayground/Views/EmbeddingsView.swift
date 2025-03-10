//
//  EmbeddingsView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import SwiftUI
import OllamaKit

struct EmbeddingsView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var prompt = ""
    @State private var embedding = [Double]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Source", selection: $model) {
                        ForEach(viewModel.models, id: \.self) { model in
                            Text(model)
                                .tag(model as String?)
                        }
                    }
                    
                    TextField("Prompt", text: $prompt)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    Text("Embedding Length")
                        .badge(embedding.count)
                }
                
                Section {
                    Button("Embed Async", action: actionAsync)
                }
            }
            .navigationTitle("Embeddings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    private func actionAsync() {
        Task {
            guard let model = model else { return }
            let data = OKEmbeddingsRequestData(model: model, prompt: prompt)
            
            let response = try await viewModel.ollamaKit.embeddings(data: data)
            guard let embedding = response.embedding else { return }
            
            self.embedding = embedding
        }
    }
}
