//
//  StorageDatabaseManager+WipeStorge.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

extension StorageDatabaseManager {
    public func wipeStorage(completion: StorageCompletionHandler) {
        write(objects: [], completion: completion, block: { realm, _ in
            realm.deleteAll()
        })
    }
}
