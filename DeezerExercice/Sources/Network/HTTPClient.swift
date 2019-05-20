//
//  HTTPClient.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

public enum HTTPEngineType {
    case urlSession(URLSessionConfiguration)
}

struct UnreachableError: Error {}

final class HTTPClient {

    private let engine: HTTPEngine

    private let urlRequestBuilder = URLRequestBuilder()

    init(engine: HTTPEngineType = .urlSession(.default)) {
        switch engine {
        case .urlSession(let configuration):
            self.engine = URLSessionEngine(configuration: configuration)
        }
    }

    func executeTask(_ request: HTTPRequest, cancelledBy cancellationToken: RequestCancellationToken) -> ExecutableRequest {
        let promise = Promise<Data>()

        do {
            let urlRequest = try urlRequestBuilder.buildURLRequest(from: request)

            engine.send(request: urlRequest, cancelledBy: cancellationToken) { (data, httpURLResponse, error) in
                if let data = data {
                    promise.resolve(with: data, statusCode: httpURLResponse?.statusCode)
                } else {
                    promise.reject(with: UnreachableError(), value: data, statusCode: httpURLResponse?.statusCode)
                }
            }
        } catch {
            promise.reject(with: error, value: nil, statusCode: nil)
        }

        return ExecutableRequest(promise: promise)
    }

    func executeTask(_ request: URLRequest, cancelledBy cancellationToken: RequestCancellationToken) -> ExecutableRequest {
        let promise = Promise<Data>()

        engine.send(request: request, cancelledBy: cancellationToken) { (data, httpURLResponse, error) in
            if let data = data {
                promise.resolve(with: data, statusCode: httpURLResponse?.statusCode)
            } else {
                promise.reject(with: UnreachableError(), value: data, statusCode: httpURLResponse?.statusCode)
            }
        }

        return ExecutableRequest(promise: promise)
    }

    func downloadTask(_ request: URLRequest, cancelledBy cancellationToken: RequestCancellationToken) -> ExecutableDownloadRequest {
        let promise = Promise<URL>()

        engine.download(request: request, cancelledBy: cancellationToken) { (url, urlResponse, error) in
            if let url = url {
                promise.resolve(with: url, statusCode: urlResponse?.statusCode)
            } else {
                promise.reject(with: UnreachableError(), value: url, statusCode: urlResponse?.statusCode)
            }
        }

        return ExecutableDownloadRequest(promise: promise)
    }
}

