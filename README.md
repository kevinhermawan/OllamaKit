# OllamaKit

A Swift library to interact with the [Ollama](https://github.com/jmorganca/ollama) API

## Overview

`OllamaKit` is a Swift library crafted to streamline interactions with the Ollama API. It encapsulates the complexities of network communication and data processing, providing a simplified and efficient interface for Swift applications to communicate with the Ollama API.

## Primary Use

`OllamaKit` is primarily designed for use within [Ollamac](https://github.com/kevinhermawan/Ollamac), a macOS app for interacting with the Ollama models. While the library offers comprehensive functionalities for Ollama API interaction, its features and optimizations are specifically aligned with the requirements of `Ollamac`.

## Documentation

You can find the documentation here: [https://kevinhermawan.github.io/OllamaKit/documentation/ollamakit](https://kevinhermawan.github.io/OllamaKit/documentation/ollamakit)

## Installation

You can add `OllamaKit` as a dependency to your project using Swift Package Manager by adding it to the dependencies value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/kevinhermawan/OllamaKit.git", .upToNextMajor(from: "1.0.0"))
]
```

Alternatively, in Xcode:

1. Open your project in Xcode.
2. Click on `File` -> `Swift Packages` -> `Add Package Dependency...`
3. Enter the repository URL: `https://github.com/kevinhermawan/OllamaKit.git`
4. Choose the version you want to add. You probably want to add the latest version.
5. Click `Add Package`.

## Acknowledgements

- [Alamofire](https://github.com/Alamofire/Alamofire)

## Used By

- [Ollamac](https://github.com/kevinhermawan/Ollamac)
