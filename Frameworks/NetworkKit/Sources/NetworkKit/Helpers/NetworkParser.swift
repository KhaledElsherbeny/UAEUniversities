//
//  NetworkParser.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

protocol NetworkParserProtocol: AnyObject {
    func handleNetworkResponse<T: Codable>(
        model: T.Type,
        data: Data?,
        response: URLResponse?,
        error: Error?
    ) -> Result<T, NetworkError>
}

final class NetworkParser: NetworkParserProtocol {
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
