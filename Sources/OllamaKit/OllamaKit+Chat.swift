//
//  OllamaKit+Chat.swift
//
//
//  Created by Kevin Hermawan on 02/01/24.
//

import Combine
import Foundation

extension OllamaKit {
    /// Starts a stream for chat responses from the Ollama API.
    ///
    /// This method allows real-time handling of chat responses using Swift's concurrency.
    ///
    /// Example usage:
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let chatData = OKChatRequestData(
    ///     model: "example-model",
    ///     messages: [
    ///         .user("What's the weather like in Tokyo?")
    ///     ],
    ///     tools: [
    ///         .function(
    ///             OKFunction(
    ///                 name: "get_current_weather",
    ///                 description: "Fetch current weather information.",
    ///                 parameters: .object([
    ///                     "location": .object([
    ///                         "type": .string("string"),
    ///                         "description": .string("The location to get the weather for, e.g., Tokyo")
    ///                     ]),
    ///                     "format": .object([
    ///                         "type": .string("string"),
    ///                         "description": .string("The format for the weather, e.g., 'celsius'."),
    ///                         "enum": .array([.string("celsius"), .string("fahrenheit")])
    ///                     ])
    ///                 ], required: ["location", "format"])
    ///             )
    ///         )
    ///     ]
    /// )
    ///
    /// Task {
    ///     do {
    ///         for try await response in ollamaKit.chat(data: chatData) {
    ///             // Handle each response here
    ///             print(response)
    ///         }
    ///     } catch {
    ///         print("Error: \(error)")
    ///     }
    /// }
    /// ```
    /// - Parameter data: The ``OKChatRequestData`` containing chat request details.
    /// - Returns: An `AsyncThrowingStream<OKChatResponse, Error>` emitting chat responses from the Ollama API.
    public func chat(data: OKChatRequestData) -> AsyncThrowingStream<OKChatResponse, Error> {
        do {
            let request = try OKRouter.chat(data: data).asURLRequest(with: baseURL)
            return OKHTTPClient.shared.stream(request: request, with: OKChatResponse.self)
        } catch {
            return AsyncThrowingStream { continuation in
                continuation.finish(throwing: error)
            }
        }
    }
    
    /// Publishes a stream of chat responses from the Ollama API using Combine.
    ///
    /// Enables real-time data handling through Combine's reactive streams.
    ///
    /// Example usage:
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let chatData = OKChatRequestData(
    ///     model: "example-model",
    ///     messages: [
    ///         .user("What's the weather like in Tokyo?")
    ///     ],
    ///     tools: [
    ///         .function(
    ///             OKFunction(
    ///                 name: "get_current_weather",
    ///                 description: "Fetch current weather information.",
    ///                 parameters: .object([
    ///                     "location": .object([
    ///                         "type": .string("string"),
    ///                         "description": .string("The location to get the weather for, e.g., Tokyo")
    ///                     ]),
    ///                     "format": .object([
    ///                         "type": .string("string"),
    ///                         "description": .string("The format for the weather, e.g., 'celsius'."),
    ///                         "enum": .array([.string("celsius"), .string("fahrenheit")])
    ///                     ])
    ///                 ], required: ["location", "format"])
    ///             )
    ///         )
    ///     ]
    /// )
    ///
    /// ollamaKit.chat(data: chatData)
    ///     .sink(receiveCompletion: { completion in
    ///         switch completion {
    ///         case .finished:
    ///             print("Stream finished")
    ///         case .failure(let error):
    ///             print("Error: \(error)")
    ///         }
    ///     }, receiveValue: { response in
    ///         // Handle each response here
    ///         print(response)
    ///     })
    ///     .store(in: &cancellables)
    /// ```
    /// - Parameter data: The ``OKChatRequestData`` containing chat request details.
    /// - Returns: An `AnyPublisher<OKChatResponse, Error>` emitting chat responses from the Ollama API.
    public func chat(data: OKChatRequestData) -> AnyPublisher<OKChatResponse, Error> {
        do {
            let request = try OKRouter.chat(data: data).asURLRequest(with: baseURL)
            return OKHTTPClient.shared.stream(request: request, with: OKChatResponse.self)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
