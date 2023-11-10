# OllamaKit

A Swift library for interacting with the Ollama API.

## Overview

`OllamaKit` is a Swift library for interacting with the Ollama API, built on top of the powerful [Alamofire](https://github.com/Alamofire/Alamofire) networking framework. It extends Alamofire's capabilities to provide a streamlined and intuitive interface for managing network interactions and data processing specific to the [Ollama API](https://github.com/jmorganca/ollama/blob/main/docs/api.md).

## Primary Use

`OllamaKit` is primarily designed for use within [Ollamac](https://github.com/kevinhermawan/Ollamac), a macOS application dedicated to interacting with Ollama models. While the library offers comprehensive functionalities for Ollama API interaction, its features and optimizations are specifically aligned with the requirements of `Ollamac`. This focus ensures that `OllamaKit` provides an ideal toolset for `Ollamac`, facilitating efficient and effective model management and interaction.

## Requirements

- iOS 13.0+ / macOS 11+

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

## License

```
MIT License

Copyright (c) 2023 Kevin Hermawan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
