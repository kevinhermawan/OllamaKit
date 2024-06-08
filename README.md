# OllamaKit

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkevinhermawan%2FOllamaKit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/kevinhermawan/OllamaKit) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkevinhermawan%2FOllamaKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/kevinhermawan/OllamaKit)

[Ollama](https://github.com/ollama/ollama) client for Swift

## Overview

`OllamaKit` is a Swift library that streamlines interactions with the Ollama API. It handles the complexities of network communication and data processing behind the scenes, providing a simple and efficient way to integrate the Ollama API.

## Primary Use

`OllamaKit` is primarily developed to power the [Ollamac](https://github.com/kevinhermawan/Ollamac), a macOS app for interacting with Ollama models. Although the library provides robust capabilities for integrating the Ollama API, its features and optimizations are tailored specifically to meet the needs of the Ollamac.

## Documentation

You can find the documentation here: [https://kevinhermawan.github.io/OllamaKit/documentation/ollamakit](https://kevinhermawan.github.io/OllamaKit/documentation/ollamakit)

## Installation

You can add `OllamaKit` as a dependency to your project using Swift Package Manager by adding it to the dependencies value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/kevinhermawan/OllamaKit.git", .upToNextMajor(from: "5.0.0"))
]
```

Alternatively, in Xcode:

1. Open your project in Xcode.
2. Click on `File` -> `Swift Packages` -> `Add Package Dependency...`
3. Enter the repository URL: `https://github.com/kevinhermawan/OllamaKit.git`
4. Choose the version you want to add. You probably want to add the latest version.
5. Click `Add Package`.

## Used By

- [Ollamac](https://github.com/kevinhermawan/Ollamac)
