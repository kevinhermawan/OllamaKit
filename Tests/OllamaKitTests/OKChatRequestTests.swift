import Testing
import Foundation
import JSONSchema
@testable import OllamaKit

@Test("Basic chat request initialization")
func testBasicChatRequestInit() {
    let messages = [
        OKChatRequestData.Message.user("Hello, how are you?")
    ]
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: messages
    )
    
    #expect(chatRequest.model == "llama2")
    #expect(chatRequest.messages.count == 1)
    #expect(chatRequest.messages[0].role.rawValue == "user")
    #expect(chatRequest.messages[0].content == "Hello, how are you?")
    #expect(chatRequest.tools == nil)
    #expect(chatRequest.format == nil)
}

@Test("Chat request with all message types")
func testChatRequestWithAllMessageTypes() {
    let messages: [OKChatRequestData.Message] = [
        .system("You are a helpful assistant."),
        .user("What's the weather?"),
        .assistant("The weather is sunny."),
        .custom(name: "weather_bot", "Temperature is 25°C")
    ]
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: messages
    )
    
    #expect(chatRequest.messages.count == 4)
    #expect(chatRequest.messages[0].role.rawValue == "system")
    #expect(chatRequest.messages[1].role.rawValue == "user")
    #expect(chatRequest.messages[2].role.rawValue == "assistant")
    #expect(chatRequest.messages[3].role.rawValue == "weather_bot")
}

@Test("Chat request with tools and JSON schema")
func testChatRequestWithToolsAndSchema() {
    let weatherFunction = OKFunction(
        name: "get_weather",
        description: "Get current weather",
        parameters: .object(
            description: "Weather parameters",
            properties: [
                "location": .string(description: "City name"),
                "unit": .string(description: "Temperature unit")
            ],
            required: ["location"]
        )
    )
    
    let responseSchema = JSONSchema.object(
        description: "Weather response",
        properties: [
            "temperature": .number(description: "Current temperature"),
            "condition": .string(description: "Weather condition")
        ],
        required: ["temperature", "condition"]
    )
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: [.user("What's the weather in Tokyo?")],
        tools: [.function(weatherFunction)],
        format: responseSchema
    )
    
    #expect(chatRequest.tools?.count == 1)
    #expect(chatRequest.tools?[0].type == "function")
    #expect(chatRequest.tools?[0].function.name == "get_weather")
    #expect(chatRequest.format != nil)
}

@Test("Chat request with options configuration")
func testChatRequestWithOptions() {
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: [.user("Hello")],
        with: { options in
            options.temperature = 0.7
            options.topP = 0.9
            options.seed = 42
        }
    )
    
    #expect(chatRequest.options?.temperature == 0.7)
    #expect(chatRequest.options?.topP == 0.9)
    #expect(chatRequest.options?.seed == 42)
}

@Test("Chat request with images")
func testChatRequestWithImages() {
    let imageBase64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII="
    
    let messages = [
        OKChatRequestData.Message.user("What's in this image?", images: [imageBase64])
    ]
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: messages
    )
    
    #expect(chatRequest.messages[0].images?.count == 1)
    #expect(chatRequest.messages[0].images?[0] == imageBase64)
}

@Test("Chat request encoding")
func testChatRequestEncoding() throws {
    let messages = [
        OKChatRequestData.Message.user("Hello")
    ]
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: messages
    )
    
    let encoder = JSONEncoder()
    let data = try encoder.encode(chatRequest)
    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
    
    #expect(json?["model"] as? String == "llama2")
    #expect(json?["stream"] as? Bool == true)
    #expect((json?["messages"] as? [[String: Any]])?.count == 1)
}

@Test("Message role raw value conversion")
func testMessageRoleRawValue() {
    let systemRole = OKChatRequestData.Message.Role.system
    let customRole = OKChatRequestData.Message.Role.custom("test_bot")
    
    #expect(systemRole.rawValue == "system")
    #expect(customRole.rawValue == "test_bot")
    
    let fromRawSystem = OKChatRequestData.Message.Role(rawValue: "system")!
    let fromRawCustom = OKChatRequestData.Message.Role(rawValue: "test_bot")!
    
    #expect(fromRawSystem == .system)
    #expect(fromRawCustom == .custom("test_bot"))
}

@Test("Complex tool configuration")
func testComplexTools() {
    let complexFunction = OKFunction(
        name: "analyze_data",
        description: "Analyze complex data structure",
        parameters: .object(
            description: "Analysis parameters",
            properties: [
                "data": .array(
                    description: "Input data points",
                    items: .object(
                        properties: [
                            "value": .number(),
                            "label": .string(),
                            "metadata": .object(
                                properties: [
                                    "timestamp": .string(description: "ISO8601 formatted timestamp"),
                                    "source": .string()
                                ]
                            )
                        ],
                        required: ["value", "label"]
                    )
                ),
                "options": .object(
                    properties: [
                        "algorithm": .enum(
                            values: [
                                .string("mean"),
                                .string("median"),
                                .string("mode")
                            ]
                        ),
                        "precision": .integer(minimum: 0, maximum: 10)
                    ]
                )
            ],
            required: ["data"]
        )
    )
    
    let chatRequest = OKChatRequestData(
        model: "llama2",
        messages: [.user("Analyze this data")],
        tools: [.function(complexFunction)]
    )
    
    let encoder = JSONEncoder()
    #expect(throws: Never.self) {
        _ = try encoder.encode(chatRequest)
    }
}
