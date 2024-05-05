//
//  NetworkManager.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

/// Protocol defining functionalities for sending network requests.
public protocol NetworkSendableProtocol {
    /// Sends a network request.
    ///
    /// - Parameters:
    ///   - model: The Codable model to decode the response.
    ///   - endpoint: The endpoint to send the request to.
    ///   - completionHandler: The completion handler returning a Result type with either the decoded model or a NetworkError.
    func send<T: Codable>(
        model: T.Type,
        endpoint: BaseEndpoint,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    )
}

/// A class responsible for managing network requests.
public final class NetworkManager {
    /// The shared instance of NetworkManager.
    public static let shared = NetworkManager()
    
    private var networkService: NetworkServiceProtocol
    private var parser: NetworkParserProtocol
    
    /// Initializes a new instance of NetworkManager.
    ///
    /// - Parameters:
    ///   - networkService: The network service to be used for sending requests. Defaults to NetworkService().
    ///   - parser: The network response parser. Defaults to NetworkParser().
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        parser: NetworkParserProtocol = NetworkParser()
    ) {
        self.networkService = networkService
        self.parser = parser
    }
}

extension NetworkManager: NetworkSendableProtocol {
    /// Sends a network request.
    ///
    /// - Parameters:
    ///   - model: The Codable model to decode the response.
    ///   - endpoint: The endpoint to send the request to.
    ///   - completionHandler: The completion handler returning a Result type with either the decoded model or a NetworkError.
    public func send<T: Codable>(
        model: T.Type,
        endpoint: BaseEndpoint,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) {
        networkService.sendRequest(to: endpoint) { [weak self] data, response, error in
            guard let self = self else {
                completionHandler(.failure(.connectionFailed))
                return
            }
            let result = self.parser.handleNetworkResponse(
                model: model,
                data: data,
                response: response,
                error: error
            )
            completionHandler(result)
        }
    }
}
