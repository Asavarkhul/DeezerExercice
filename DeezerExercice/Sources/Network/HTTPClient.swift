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

final class HTTPClient {

    private let engine: HTTPEngine

    init(engine: HTTPEngineType = .urlSession(.default)) {
        switch engine {
        case .urlSession(let configuration):
            self.engine = URLSessionEngine(configuration: configuration)
        }
    }

    func executeTask(_ request: URLRequest, cancelledBy cancellationToken: RequestCancellationToken) -> ExecutableRequest {
        let promise = Promise()

        // ⚠️ Here we should add a throwable part for building URLRequest and provide corresponding promise.

        engine.send(request: request, cancelledBy: cancellationToken) { (data, httpURLResponse, error) in
            if let data = data {
                promise.resolve(with: data, statusCode: httpURLResponse?.statusCode)
            } else {
                promise.reject(with: UnreachableError(), data: data, statusCode: httpURLResponse?.statusCode)
            }
        }

        return ExecutableRequest(promise: promise)
    }
}

struct UnreachableError: Error {}

final class ExecutableRequest {

    private let responsePromise: Promise

    init(promise: Promise) {
        self.responsePromise = promise
    }

    func processCodableResponse<D: Codable>(callback: @escaping (HTTPResponse<D>) -> Void) {
        responsePromise.observe { result in
            switch result {
            case .value(let data, let statusCode):
                do {
                    let object = try JSONDecoder().decode(D.self, from: data)
                    callback(HTTPResponse(result: .success(object), originalData: data, statusCode: statusCode))
                } catch {
                    callback(HTTPResponse(result: .failure(error), originalData: data, statusCode: statusCode))
                }
            case .error(let error, let data, let statusCode):
                callback(HTTPResponse(result: .failure(error), originalData: data, statusCode: statusCode))
            }
        }
    }

    public func processDataResponse(callback: @escaping (HTTPResponse<Data>) -> Void) {
        responsePromise.observe { (result) in
            switch result {
            case .value(let data, let statusCode):
                let object = data
                callback(HTTPResponse(result: .success(object), originalData: data, statusCode: statusCode))
            case .error(let error, let data, let statusCode):
                callback(HTTPResponse(result: .failure(error), originalData: data, statusCode: statusCode))
            }
        }
    }
}

