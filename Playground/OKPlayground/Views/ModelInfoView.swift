//
//  ModelInfoView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 09/06/24.
//

import SwiftUI
import OllamaKit

struct ModelInfoView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var modelInfo: OKModelInfoResponse? = nil
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
                }
                
                if let modelInfo {
                    Section("License") {
                        Text(modelInfo.license)
                    }
                    
                    Section("Modelfile") {
                        Text(modelInfo.modelfile)
                    }
                    
                    Section("Parameters") {
                        Text(modelInfo.parameters)
                    }
                    
                    Section("Template") {
                        Text(modelInfo.template)
                    }
                }
                
                Section {
                    Button("Get Async", action: actionAsync)
                }
            }
            .navigationTitle("Model Info")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    private func actionAsync() {
        Task {
            guard let model = model else { return }
            let data = OKModelInfoRequestData(name: model)
            
            let response = try await viewModel.ollamaKit.modelInfo(data: data)
            
            self.modelInfo = response
        }
    }
}
