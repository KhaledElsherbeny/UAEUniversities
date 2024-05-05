//
//  File.swift
//  
//
//  Created by Khalid on 05/05/2024.
//

import Foundation
import Domain

/// Represents the UI model for a university list item.
struct UniversityListItemUIModel {
    /// The name of the university.
    let name: String
    /// The state or province of the university.
    let stateProvince: String?
    
    /// Initializes a `UniversityListItemUIModel` with a `UniversityListItem`.
    /// - Parameter universityListItem: The `UniversityListItem` used to create the UI model.
    init(universityListItem: UniversityListItem) {
        self.name = universityListItem.name
        self.stateProvince = universityListItem.stateProvince
    }
}

