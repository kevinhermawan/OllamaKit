# OllamaKit

A Swift library to interact with the [Ollama](https://github.com/jmorganca/ollama) API.

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
