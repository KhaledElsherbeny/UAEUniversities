//
//  NetworkService.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

/// Typealias for network request completion handler.
public typealias NetworkRequestCompletion = (Data?, URLResponse?, Error?) -> Void

/// Protocol defining functionalities for sending network requests.
protocol NetworkServiceProtocol {
    /// Sends a network request to the provided endpoint.
    ///
    /// - Parameters:
    ///   - endPoint: The endpoint to send the request to.
    ///   - completion: The completion handler.
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    )
}

/// Class responsible for sending network requests.
final class NetworkService: NetworkServiceProtocol {
    private let networkClient: NetworkServiceProtocol
    
    /// Initializes the network service with a network client.
    ///
    /// - Parameter networkClient: The network client.
    init(networkClient: NetworkServiceProtocol = URLSession(configuration: .default)) {
        self.networkClient = networkClient
    }
    
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    ) {
        networkClient.sendRequest(
            to: endPoint,
            completion: completion
        )
    }
}

extension URLSession: NetworkServiceProtocol {
    /// Sends a network request to the provided endpoint using URLSession.
    ///
    /// - Parameters:
    ///   - endPoint: The endpoint to send the request to.
    ///   - completion: The completion handler.
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    ) {
        let request = endPoint.urlRequest
        dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                NetworkLogger.log(request: request)
                completion(data, response, error)
                NetworkLogger.log(response: data)
            }
        }.resume()
    }
}
