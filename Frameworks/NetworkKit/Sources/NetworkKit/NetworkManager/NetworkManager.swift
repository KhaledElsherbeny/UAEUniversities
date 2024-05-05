//
//  NetworkManager.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

public protocol NetworkSendableProtocol {
    func send<T: Codable>(
        model: T.Type,
        endpoint: BaseEndpoint,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    )
}

public final class NetworkManager {
    public static let shared = NetworkManager()
    
    private var networkService: NetworkServiceProtocol
    private var parser: NetworkParserProtocol
    
    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        parser: NetworkParserProtocol = NetworkParser()
    ) {
        self.networkService = networkService
        self.parser = parser
    }
}

extension NetworkManager: NetworkSendableProtocol {
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
