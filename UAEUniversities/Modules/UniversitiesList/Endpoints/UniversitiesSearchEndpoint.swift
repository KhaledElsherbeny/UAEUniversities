//
//  UniversitiesSearchEndpoint.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import NetworkKit

enum UniversitiesSearchEndpoint: BaseEndpoint {
    case getUniversities(country: String)
    
    var path: String {
        switch self {
        case .getUniversities(let country):
            return "?country=\(country)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUniversities:
            return .get
        }
    }
}
