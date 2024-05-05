//
//  UniversityListItemRealm.swift
//
//
//  Created by Khalid on 05/05/2024.
//

import RealmSwift
import Foundation
import Domain

/// Realm object representing a university item.
@objc(UniversityListItem)
class UniversityListItemRealm: Object {
    /// Primary key for the object.
    @Persisted(primaryKey: true) var id: ObjectId
    /// The alpha two code of the country.
    @Persisted var alphaTwoCode: String
    /// The name of the university.
    @Persisted var name: String
    /// The country where the university is located.
    @Persisted var country: String
    /// The domains associated with the university.
    @Persisted var domains = List<String>()
    /// The web pages associated with the university.
    @Persisted var webPages = List<String>()
    /// The state or province where the university is located.
    @Persisted var stateProvince: String?
}

extension UniversityListItemRealm {
    /// Convenience initializer to create a Realm university item from a DTO.
    /// - Parameter universityListItem: The DTO representing the university item.
    convenience init(universityListItem: UniversityListItem) {
        self.init()
        name = universityListItem.name
        alphaTwoCode = universityListItem.alphaTwoCode
        country = universityListItem.country
        stateProvince = universityListItem.stateProvince
        universityListItem.domains.forEach {
            domains.append($0)
        }
        universityListItem.webPages.forEach {
            webPages.append($0)
        }
    }
}
