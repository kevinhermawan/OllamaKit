//
//  CopyModelView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 08/06/24.
//

import SwiftUI
import OllamaKit

struct CopyModelView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String?
    @State private var destination: String = ""
    
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
                    
                    TextField("Destination", text: $destination)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    Button("Copy Async", action: actionAsync)
                }
            }
            .navigationTitle("Copy Model")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    private func actionAsync() {
        Task {
            guard let model = model else { return }
            let data = OKCopyModelRequestData(source: model, destination: destination)
            
            try await viewModel.ollamaKit.copyModel(data: data)
        }
    }
}
