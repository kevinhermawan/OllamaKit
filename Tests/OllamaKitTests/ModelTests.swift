//
//  ModelTests.swift
//  OllamaKit
//
//  Created by Norikazu Muramoto on 2025/01/22.
//


import Testing
import Foundation
import OllamaKit

@Test("Basic chat functionality for all models")
func testAllModelsBasicChat() async throws {
    let models = ["deepseek-r1:8b", "phi4", "llama3.2"]
    let ollamaKit = OllamaKit()
    
    for model in models {
        print("Testing model: \(model)")
        
        // Basic chat test
        let chatData = OKChatRequestData(
            model: model,
            messages: [.user("What is 2+2?")]
        )
        
        var response = ""
        for try await chatResponse in ollamaKit.chat(data: chatData) {
            if let content = chatResponse.message?.content {
                response += content
            }
        }
        
        #expect(!response.isEmpty, "Model \(model) should return a response")
        #expect(response.contains("4"), "Model \(model) should correctly answer 2+2=4")
    }
}

@Test("Tool calling functionality for all models")
func testAllModelsToolCalling() async throws {
    let models = ["deepseek-r1:8b", "phi4", "llama3.2"]
    let ollamaKit = OllamaKit()
    
    // Weather function definition
    let weatherFunction = OKFunction(
        name: "get_current_weather",
        description: "Get the current weather in a given location",
        parameters: .object(
            description: "Parameters for the weather function",
            properties: [
                "location": .string(description: "The city and state, e.g. San Francisco, CA"),
                "unit": .string(description: "The temperature unit to use: 'celsius' or 'fahrenheit'")
            ],
            required: ["location", "unit"]
        )
    )

    for model in models {
        print("Testing model: \(model) with tool calling")
        
        let chatData = OKChatRequestData(
            model: model,
            messages: [
                .system("You are a helpful assistant that uses the provided weather function when asked about weather."),
                .user("What's the weather like in Tokyo?")
            ],
            tools: [.function(weatherFunction)]
        )
        
        var hasToolCall = false
        var functionName: String?
        
        for try await chatResponse in ollamaKit.chat(data: chatData) {
            if let toolCalls = chatResponse.message?.toolCalls {
                hasToolCall = true
                functionName = toolCalls.first?.function?.name
            }
        }
        
        #expect(hasToolCall, "Model \(model) should attempt to use the weather tool")
        #expect(functionName == "get_current_weather", "Model \(model) should call the correct function")
    }
}

@Test("Response format validation for all models")
func testAllModelsResponseFormat() async throws {
    let models = ["deepseek-r1:8b", "phi4", "llama3.2"]
    let ollamaKit = OllamaKit()
    
    for model in models {
        print("Testing model: \(model) response format")
        
        let chatData = OKChatRequestData(
            model: model,
            messages: [
                .system("You should respond in complete sentences."),
                .user("List three colors.")
            ]
        )
        
        var response = ""
        var responseComplete = false
        
        for try await chatResponse in ollamaKit.chat(data: chatData) {
            if let content = chatResponse.message?.content {
                response += content
            }
            if chatResponse.done {
                responseComplete = true
            }
        }
        
        #expect(responseComplete, "Model \(model) should complete its response")
        #expect(response.contains("."), "Model \(model) should respond in complete sentences")
        #expect(response.components(separatedBy: .whitespaces).count > 5, "Model \(model) should provide a substantial response")
    }
}

@Test("Error handling for all models")
func testAllModelsErrorHandling() async throws {
    let models = ["deepseek-r1:8b", "phi4", "llama3.2"]
    let ollamaKit = OllamaKit()
    
    for model in models {
        print("Testing model: \(model) error handling")
        
        // Test with empty message
        do {
            let chatData = OKChatRequestData(
                model: model,
                messages: []
            )
            
            var receivedResponse = false
            for try await _ in ollamaKit.chat(data: chatData) {
                receivedResponse = true
            }
            #expect(!receivedResponse, "Model \(model) should not process empty messages")
        } catch {
            // Error is expected
        }
        
        // Test with invalid model name
        do {
            let chatData = OKChatRequestData(
                model: model + "_invalid",
                messages: [.user("Test")]
            )
            
            var receivedResponse = false
            for try await _ in ollamaKit.chat(data: chatData) {
                receivedResponse = true
            }
            #expect(!receivedResponse, "Invalid model name should not return response")
        } catch {
            // Error is expected
        }
    }
}

@Test("Context handling for all models")
func testAllModelsContextHandling() async throws {
    let models = ["deepseek-r1:8b", "phi4", "llama3.2"]
    let ollamaKit = OllamaKit()
    
    for model in models {
        print("Testing model: \(model) context handling")
        
        let chatData = OKChatRequestData(
            model: model,
            messages: [
                .system("You are a helpful assistant."),
                .user("My name is Alice."),
                .assistant("Nice to meet you, Alice!"),
                .user("What's my name?")
            ]
        )
        
        var response = ""
        for try await chatResponse in ollamaKit.chat(data: chatData) {
            if let content = chatResponse.message?.content {
                response += content
            }
        }
        
        #expect(response.contains("Alice"), "Model \(model) should remember context")
    }
}
