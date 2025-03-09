//
//  OllamaKit+PullModel.swift
//
//
//  Created by Lukas Pistrol on 25.11.24.
//

import Foundation

extension OllamaKit {
    /// Establishes an asynchronous stream for pulling a model from the ollama library.
    ///
    /// This method will periodically yield ``OKPullModelResponse`` structures as the model is being pulled.
    /// Depending on the size of the model and the speed of the internet connection, this process may take a while.
    /// The stream will complete once the model has been fully pulled.
    ///
    /// ```swift
    /// let ollamaKit = OllamaKit()
    /// let reqData = OKPullModelRequestData(model: "llama3.2")
    ///
    /// for try await response in ollamaKit.pullModel(data: reqData) {
    ///   print(response.status)
    ///   if let progress = response.completed, let total = response.total {
    ///     print("Progress: \(progress)/\(total) bytes")
    ///   }
    /// }
    /// ```
    ///
    /// - Parameter data: The ``OKPullModelRequestData`` used to initiate the chat streaming from the ollama library.
    /// - Returns: An asynchronous stream that emits ``OKPullModelResponse``.
    public func pullModel(data: OKPullModelRequestData) -> AsyncThrowingStream<OKPullModelResponse, Error> {
        do {
            let request = try OKRouter.pullModel(data: data).asURLRequest(with: baseURL)
            
            return OKHTTPClient.shared.stream(request: request, with: OKPullModelResponse.self)
        } catch {
            return AsyncThrowingStream { continuation in
                continuation.finish(throwing: error)
            }
        }
    }
}
