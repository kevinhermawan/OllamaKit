//
//  ChatWithToolsView.swift
//  OKPlayground
//
//  Created by Kevin Hermawan on 28/07/24.
//

import OllamaKit
import SwiftUI

struct ChatWithToolsView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var model: String? = nil
    @State private var prompt = ""
    
    @State private var toolCalledResponse = ""
    @State private var argumentsResponse = ""
    @State private var locationResponse = ""
    @State private var formatResponse = ""
    
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
                    
                    TextField("Prompt", text: $prompt)
                }
                
                Section {
                    Button("Chat Async", action: actionAsync)
                }
                
                Section("Response") {
                    Text(toolCalledResponse)
                    Text(argumentsResponse)
                }
                
                Section("Arguments") {
                    Text("Location: \(locationResponse)")
                    Text("Format: \(formatResponse)")
                }
            }
            .navigationTitle("Chat with Tools")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                model = viewModel.models.first
            }
        }
    }
    
    func actionAsync() {
        clearResponses()
        
        guard let model = model else { return }
        let messages = [OKChatRequestData.Message(role: .user, content: prompt)]
        let data = OKChatRequestData(model: model, messages: messages, tools: getTools())
        
        Task {
            for try await chunk in viewModel.ollamaKit.chat(data: data) {
                if let toolCalls = chunk.message?.toolCalls {
                    for toolCall in toolCalls {
                        if let function = toolCall.function {
                            setResponses(function)
                        }
                    }
                }
            }
        }
    }
    
    private func getTools() -> [OKJSONValue] {
        return [
            .object([
                "type": .string("function"),
                "function": .object([
                    "name": .string("get_current_weather"),
                    "description": .string("Get the current weather for a location"),
                    "parameters": .object([
                        "type": .string("object"),
                        "properties": .object([
                            "location": .object([
                                "type": .string("string"),
                                "description": .string("The location to get the weather for, e.g. San Francisco, CA")
                            ]),
                            "format": .object([
                                "type": .string("string"),
                                "description": .string("The format to return the weather in, e.g. 'celsius' or 'fahrenheit'"),
                                "enum": .array([.string("celsius"), .string("fahrenheit")])
                            ])
                        ]),
                        "required": .array([.string("location"), .string("format")])
                    ])
                ])
            ])
        ]
    }
    
    private func setResponses(_ function: OKChatResponse.Message.ToolCall.Function) {
        self.toolCalledResponse = function.name ?? ""
        self.argumentsResponse = "\(function.arguments ?? .string("No arguments"))"
        
        if let arguments = function.arguments {
            switch arguments {
            case .object(let argDict):
                if let location = argDict["location"], case .string(let locationValue) = location {
                    self.locationResponse = locationValue
                }
                
                if let format = argDict["format"], case .string(let formatValue) = format {
                    self.formatResponse = formatValue
                }
            default:
                print("Unexpected arguments format")
            }
        } else {
            print("No arguments provided")
        }
    }
    
    private func clearResponses() {
        self.toolCalledResponse = ""
        self.argumentsResponse = ""
        self.locationResponse = ""
        self.formatResponse = ""
    }
}
