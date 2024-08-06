//
//  ChatView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 09/06/24.
//

import Combine
import SwiftUI
import OllamaKit

struct ChatView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var temperature: Double = 0.5
    @State private var prompt = ""
    @State private var response = ""
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Model") {
                    Picker("Selected Model", selection: $model) {
                        ForEach(viewModel.models, id: \.self) { model in
                            Text(model)
                                .tag(model as String?)
                        }
                    }
                }
                
                Section("Temperature") {
                    Slider(value: $temperature, in: 0...1, step: 0.1) {
                        Text("Temperature")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("1")
                    }
                }
                
                Section("Prompt") {
                    TextField("Prompt", text: $prompt)
                }
                
                Section {
                    Button("Chat Async", action: actionAsync)
                    Button("Chat Combine", action: actionCombine)
                }
                
                Section("Response") {
                    Text(response)
                }
            }
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    func actionAsync() {
        self.response = ""
        
        guard let model = model else { return }
        let messages = [OKChatRequestData.Message(role: .user, content: prompt)]
        var data = OKChatRequestData(model: model, messages: messages)
        data.options = OKCompletionOptions(temperature: temperature)
        
        Task {
            for try await chunk in viewModel.ollamaKit.chat(data: data) {
                self.response += chunk.message?.content ?? ""
            }
        }
    }
    
    func actionCombine() {
        self.response = ""
        
        guard let model = model else { return }
        let messages = [OKChatRequestData.Message(role: .user, content: prompt)]
        var data = OKChatRequestData(model: model, messages: messages)
        data.options = OKCompletionOptions(temperature: temperature)
        
        viewModel.ollamaKit.chat(data: data)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            } receiveValue: { value in
                self.response += value.message?.content ?? ""
            }
            .store(in: &cancellables)
    }
}
