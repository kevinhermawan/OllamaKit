//
//  ChatWithFormatView.swift
//  OKPlayground
//
//  Created by Michel-Andre Chirita on 30/12/2024.
//

import OllamaKit
import SwiftUI

struct ChatWithFormatView: View {
    
    enum ViewState {
        case idle
        case loading
        case error(String)
    }
    
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    /// TIP: be sure to include "return as JSON" in your prompt
    @State private var prompt = "Lists of the 10 biggest countries in the world with their iso code as id, name and capital, return as JSON"
    @State private var viewState: ViewState = .idle
    
    @State private var responseItems: [ResponseItem] = []
    
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
                    
                    TextField("Prompt", text: $prompt, axis: .vertical)
                        .lineLimit(5)
                }
                
                Section {
                    Button("Chat Async", action: actionAsync)
                }
                
                switch viewState {
                case .idle:
                    EmptyView()
                    
                case .loading:
                    ProgressView()
                        .id(UUID())
                    
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.red)
                }
                
                Section("Response") {
                    ForEach(responseItems) { item in
                        Text("Country: " + item.country + ", capital: " + item.capital)
                    }
                }
            }
            .navigationTitle("Chat with Format")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    func actionAsync() {
        clearResponse()
        
        guard let model = model else { return }
        let messages = [OKChatRequestData.Message(role: .user, content: prompt)]
        var data = OKChatRequestData(model: model, messages: messages, format: getFormat())
        data.options = OKCompletionOptions(temperature: 0) /// TIP: better results with temperature = 0
        self.viewState = .loading
        
        Task {
            do {
                var message: String = ""
                for try await chunk in viewModel.ollamaKit.chat(data: data) {
                    if let content = chunk.message?.content {
                        message.append(content)
                    }
                    if chunk.done {
                        self.viewState = .idle
                        decodeResponse(message)
                    }
                }
            } catch {
                print("Error:", error.localizedDescription)
                self.viewState = .error(error.localizedDescription)
            }
        }
    }
    
    private func getFormat() -> OKJSONValue {
        return
            .object(["type": .string("array"),
                     "items": .object([
                        "type" : .string("object"),
                        "properties": .object([
                            "id": .object(["type" : .string("string")]),
                            "country": .object(["type" : .string("string")]),
                            "capital": .object(["type" : .string("string")]),
                        ]),
                        "required": .array([.string("id"), .string("country"), .string("capital")])
                     ])
                    ])
    }
    
    private func decodeResponse(_ content: String) {
        do {
            guard let data = content.data(using: .utf8) else { return }
            let response = try JSONDecoder().decode([ResponseItem].self, from: data)
            self.responseItems = response
        } catch {
            print("Error message: \(error)")
            self.viewState = .error(error.localizedDescription)
        }
    }
    
    private func clearResponse() {
        self.responseItems = []
    }
}

struct ResponseItem: Identifiable, Codable {
    let id: String
    let country: String
    let capital: String
}
