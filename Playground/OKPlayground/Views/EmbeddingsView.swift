//
//  EmbeddingsView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import Combine
import SwiftUI
import OllamaKit

struct EmbeddingsView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var prompt = ""
    @State private var embedding = [Double]()
    @State private var cancellables = Set<AnyCancellable>()
    
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
                    Button("Embed Combine", action: actionCombine)
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
    
    private func actionCombine() {
        guard let model = model else { return }
        let data = OKEmbeddingsRequestData(model: model, prompt: prompt)
        
        viewModel.ollamaKit.embeddings(data: data)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            } receiveValue: { value in
                guard let embedding = value.embedding else { return }
                
                self.embedding = embedding
            }
            .store(in: &cancellables)
    }
}
