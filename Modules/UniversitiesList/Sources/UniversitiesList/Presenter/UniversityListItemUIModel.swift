//
//  File.swift
//  
//
//  Created by Khalid on 05/05/2024.
//

import Foundation
import Domain

struct UniversityListItemUIModel {
    let name: String
    let stateProvince: String?
    
    init(universityListItem: UniversityListItem) {
        self.name = universityListItem.name
        self.stateProvince = universityListItem.stateProvince
    }
}

