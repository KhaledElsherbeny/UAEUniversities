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
    ///   - completion: The completion handler to call when the request is complete.
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    )
    
    /// Sends a network request to the provided endpoint using async/await.
    ///
    /// - Parameter endPoint: The endpoint to send the request to.
    /// - Throws: An error if the network request fails.
    /// - Returns: A tuple containing the data and URL response.
    func sendRequest(
        to endPoint: BaseEndpoint
    ) async throws -> (Data, URLResponse)
}

/// Class responsible for sending network requests.
final class NetworkService: NetworkServiceProtocol {
    private let networkClient: NetworkServiceProtocol
    
    /// Initializes the network service with a network client.
    ///
    /// - Parameter networkClient: The network client to use for sending requests.
    init(networkClient: NetworkServiceProtocol = URLSession(configuration: .default)) {
        self.networkClient = networkClient
    }
    
    /// Sends a network request to the provided endpoint.
    ///
    /// - Parameters:
    ///   - endPoint: The endpoint to send the request to.
    ///   - completion: The completion handler to call when the request is complete.
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    ) {
        networkClient.sendRequest(to: endPoint, completion: completion)
    }
    
    /// Sends a network request to the provided endpoint using async/await.
    ///
    /// - Parameter endPoint: The endpoint to send the request to.
    /// - Throws: An error if the network request fails.
    /// - Returns: A tuple containing the data and URL response.
    func sendRequest(
        to endPoint: BaseEndpoint
    ) async throws -> (Data, URLResponse) {
        try await networkClient.sendRequest(to: endPoint)
    }
}

extension URLSession: NetworkServiceProtocol {
    /// Sends a network request to the provided endpoint using URLSession.
    ///
    /// - Parameters:
    ///   - endPoint: The endpoint to send the request to.
    ///   - completion: The completion handler to call when the request is complete.
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    ) {
        let request = endPoint.urlRequest
        dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                NetworkLogger.log(request: request)
                completion(data, response, error)
                NetworkLogger.log(response: response, data: data)
                if let error = error {
                    NetworkLogger.log(error: error)
                }
            }
        }.resume()
    }
    
    /// Sends a network request to the provided endpoint using async/await and logs the request and response.
    ///
    /// - Parameter endPoint: The endpoint to send the request to.
    /// - Throws: An error if the network request fails.
    /// - Returns: A tuple containing the data and URL response.
    func sendRequest(
        to endPoint: BaseEndpoint
    ) async throws -> (Data, URLResponse) {
        let request = endPoint.urlRequest
        do {
            let (data, response) = try await data(for: request)
            NetworkLogger.log(request: request)
            NetworkLogger.log(response: response, data: data)
            return (data, response)
        } catch {
            NetworkLogger.log(error: error)
            throw error
        }
    }
}
