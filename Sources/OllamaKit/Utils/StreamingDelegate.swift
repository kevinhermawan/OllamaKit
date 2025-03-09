//
//  StreamingDelegate.swift
//
//
//  Created by Kevin Hermawan on 09/06/24.
//

import Foundation
#if canImport(Combine)
@preconcurrency import Combine

internal class StreamingDelegate: NSObject, URLSessionDataDelegate, @unchecked Sendable {
    private let subject = PassthroughSubject<Data, URLError>()
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        subject.send(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            subject.send(completion: .failure(error as? URLError ?? URLError(.unknown)))
        } else {
            subject.send(completion: .finished)
        }
    }
    
    func publisher() -> AnyPublisher<Data, URLError> {
        subject.eraseToAnyPublisher()
    }
}
#endif

#if canImport(FoundationNetworking)
import FoundationNetworking
internal final class StreamingDelegate: NSObject, URLSessionDataDelegate, @unchecked Sendable {

    let urlResponseCallback: (@Sendable (URLResponse) -> Void)?
    let dataCallback: (@Sendable (inout Data) -> Void)?
    let completionCallback: (@Sendable (Error?) -> Void)?

    var buffer = Data()

    init(urlResponseCallback: (@Sendable (URLResponse) -> Void)?,
         dataCallback: (@Sendable (inout Data) -> Void)?,
         completionCallback: (@Sendable (Error?) -> Void)?
    ) {
        self.urlResponseCallback = urlResponseCallback
        self.dataCallback = dataCallback
        self.completionCallback = completionCallback
    }

    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        // Handle the URLResponse here
        urlResponseCallback?(response)
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        buffer.append(data)

        // Handle the incoming data chunk here
        dataCallback?(&buffer)
    }

    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        // Handle completion or errors
        completionCallback?(error)
    }
}
#endif
