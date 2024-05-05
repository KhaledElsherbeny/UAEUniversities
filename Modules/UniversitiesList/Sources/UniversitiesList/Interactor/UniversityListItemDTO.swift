//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

/// DTO (Data Transfer Object) representing a university item.
struct UniversityListItemDTO: Codable {
    /// The alpha two code of the country.
    let alphaTwoCode: String
    /// The name of the university.
    let name: String
    /// The country where the university is located.
    let country: String
    /// The domains associated with the university.
    let domains: [String]
    /// The web pages associated with the university.
    let webPages: [String]
    /// The state or province where the university is located.
    let stateProvince: String?
    
    private enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case name
        case country
        case domains
        case webPages = "web_pages"
        case stateProvince = "state-province"
    }
}
