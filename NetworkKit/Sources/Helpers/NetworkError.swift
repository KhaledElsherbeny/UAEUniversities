//
//  NetworkError.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

public enum NetworkError: Error {
    case authenticationError
    case badRequest
    case outdated
    case connectionFailed
    case noData
    case unableToDecode
    case serverError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .authenticationError:
            return NSLocalizedString("You need to be authenticated first.", comment: "")
        case .badRequest:
            return NSLocalizedString("Bad request.", comment: "")
        case .outdated:
            return NSLocalizedString("The requested URL is outdated.", comment: "")
        case .connectionFailed:
            return NSLocalizedString("Network request failed.", comment: "")
        case .noData:
            return NSLocalizedString("Response returned with no data to decode.", comment: "")
        case .unableToDecode:
            return NSLocalizedString("Unable to decode the response.", comment: "")
        case .serverError:
            return NSLocalizedString("Server error.", comment: "")
        }
    }
}
