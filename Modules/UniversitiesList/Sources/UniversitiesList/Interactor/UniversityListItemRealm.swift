//
//  UniversityListItemRealm.swift
//
//
//  Created by Khalid on 05/05/2024.
//

import RealmSwift
import Foundation
import Domain

@objc(UniversityListItem)
class UniversityListItemRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var alphaTwoCode: String
    @Persisted var name: String
    @Persisted var country: String
    @Persisted var domains = List<String>()
    @Persisted var webPages = List<String>()
    @Persisted var stateProvince: String?
}

extension UniversityListItemRealm {
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
