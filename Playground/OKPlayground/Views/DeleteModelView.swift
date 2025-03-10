//
//  DeleteModelView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import SwiftUI
import OllamaKit

struct DeleteModelView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    
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
}
