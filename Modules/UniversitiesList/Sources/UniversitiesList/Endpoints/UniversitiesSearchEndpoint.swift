//
//  UniversitiesSearchEndpoint.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import NetworkKit

/// Enum representing the endpoints for university search API.
enum UniversitiesSearchEndpoint: BaseEndpoint {
    
    /// Case to get the list of universities based on country.
    case getUniversities(country: String)
    
    /// The path for the endpoint.
    var path: String {
        switch self {
        case .getUniversities:
            return "search"
        }
    }
    
    /// The HTTP method for the endpoint.
    var method: HTTPMethod {
        switch self {
        case .getUniversities:
            return .get
        }
    }
    
    /// The parameters for the endpoint.
    var parameters: Parameters {
        switch self {
        case .getUniversities(let country):
            return ["country": country]
        }
    }
}

