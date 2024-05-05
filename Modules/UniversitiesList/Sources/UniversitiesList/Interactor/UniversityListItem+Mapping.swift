//
//  UniversityListItem+Mapping.swift
//
//
//  Created by Khalid on 05/05/2024.
//

import Foundation
import Domain

extension UniversityListItem {
    init(universityListItem: UniversityListItemDTO) {
        self.init()
        name = universityListItem.name
        alphaTwoCode = universityListItem.alphaTwoCode
        country = universityListItem.country
        domains = universityListItem.domains
        webPages = universityListItem.webPages
        stateProvince = universityListItem.stateProvince
    }
}

extension UniversityListItem {
    init(universityListItem: UniversityListItemRealm) {
        self.init()
        name = universityListItem.name
        alphaTwoCode = universityListItem.alphaTwoCode
        country = universityListItem.country
        domains = Array(universityListItem.domains)
        webPages = Array(universityListItem.webPages)
        stateProvince = universityListItem.stateProvince
    }
}
