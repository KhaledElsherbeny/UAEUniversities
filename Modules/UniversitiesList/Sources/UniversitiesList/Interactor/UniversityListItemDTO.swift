//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

struct UniversityListItemDTO: Codable {
    let alphaTwoCode: String
    let name: String
    let country: String
    let domains: [String]
    let webPages: [String]
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
