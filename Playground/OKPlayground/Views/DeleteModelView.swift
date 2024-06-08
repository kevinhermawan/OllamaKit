//
//  DeleteModelView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import Combine
import SwiftUI
import OllamaKit

struct DeleteModelView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Model", selection: $model) {
                        ForEach(viewModel.models, id: \.self) { model in
                            Text(model)
                                .tag(model as String?)
                        }
                    }
                }
                
                Section {
                    Button("Delete Async", action: actionAsync)
                    Button("Delete Combine", action: actionCombine)
                }
            }
            .navigationTitle("Delete Model")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    private func actionAsync() {
        Task {
            guard let model = model else { return }
            let data = OKDeleteModelRequestData(name: model)
            
            try await viewModel.ollamaKit.deleteModel(data: data)
        }
    }
    
    private func actionCombine() {
        guard let model = model else { return }
        let data = OKDeleteModelRequestData(name: model)
        
        viewModel.ollamaKit.deleteModel(data: data)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            } receiveValue: { value in
                print("Value:", value)
            }
            .store(in: &cancellables)
    }
}

#Preview {
    DeleteModelView()
}
