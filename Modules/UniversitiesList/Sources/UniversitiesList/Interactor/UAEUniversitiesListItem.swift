//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

struct UniversityListItem {
    let alphaTwoCode: String
    let name: String
    let country: String
    let domains: [String]
    let webPages: [String]
    let stateProvince: String?
}

struct UniversityListItemUIModel {
    let name: String
    let stateProvince: String?
    
    init(universityListItem: UniversityListItem) {
        self.name = universityListItem.name
        self.stateProvince = universityListItem.stateProvince
    }
}


extension UniversityListItem {
    init(universityListItemDTO: UniversitiesListItem) {
        self.alphaTwoCode = universityListItemDTO.alphaTwoCode
        self.name = universityListItemDTO.name
        self.country = universityListItemDTO.country
        self.domains = universityListItemDTO.domains
        self.webPages = universityListItemDTO.webPages
        self.stateProvince = universityListItemDTO.stateProvince
    }
}

struct UniversitiesListItem: Codable {
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
