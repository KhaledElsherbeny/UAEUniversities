//
//  NetworkService.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

public typealias NetworkRequestCompletion = (Data?, URLResponse?, Error?) -> Void

protocol NetworkServiceProtocol {
    func sendRequest(
        to endPoint: BaseEndpoint,
        completion: @escaping NetworkRequestCompletion
    )
}

final class NetworkService: NetworkServiceProtocol {
    private let networkClient: NetworkServiceProtocol
    
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
