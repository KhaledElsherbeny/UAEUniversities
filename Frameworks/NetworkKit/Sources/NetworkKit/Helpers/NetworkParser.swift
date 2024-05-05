//
//  NetworkParser.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

/// Protocol defining functionalities for parsing network responses.
protocol NetworkParserProtocol: AnyObject {
    /// Handles the network response based on the provided model.
    ///
    /// - Parameters:
    ///   - model: The model type to decode the response.
    ///   - data: The response data.
    ///   - response: The URL response.
    ///   - error: The error, if any.
    /// - Returns: A Result object with the decoded model or a NetworkError.
    func handleNetworkResponse<T: Codable>(
        model: T.Type,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<T, NetworkError>
}

/// Class responsible for parsing network responses.
final class NetworkParser: NetworkParserProtocol {
    /// Handles the network response based on the provided model.
    ///
    /// - Parameters:
    ///   - model: The model type to decode the response.
    ///   - data: The response data.
    ///   - response: The URL response.
    ///   - error: The error, if any.
    /// - Returns: A Result object with the decoded model or a NetworkError.
    func handleNetworkResponse<T: Codable>(
        model: T.Type,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<T, NetworkError> {
        if let _ = error {
            return .failure(.connectionFailed)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.connectionFailed)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return parseData(model: model, data: data)
        case 401:
            return .failure(.authenticationError)
        case 400...499:
            return .failure(.badRequest)
        case 500...599:
            return .failure(.serverError)
        case 600:
            return .failure(.outdated)
        default:
            return .failure(.connectionFailed)
        }
    }
    
    /// Parses the response data to the provided model type.
    ///
    /// - Parameters:
    ///   - model: The model type to decode the response.
    ///   - data: The response data.
    /// - Returns: A Result object with the decoded model or a NetworkError.
    func parseData<T: Codable>(
        model: T.Type,
        data: Data?
    )-> Result<T, NetworkError> {
        guard let data = data else {
            return .failure(.noData)
        }
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return .success(model)
        } catch {
            return .failure(.unableToDecode)
        }
    }
}
