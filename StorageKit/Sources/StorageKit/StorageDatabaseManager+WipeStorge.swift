//
//  StorageDatabaseManager+WipeStorge.swift
//
//
//  Created by Khalid on 04/05/2024.
//

import Foundation

extension StorageDatabaseManager {
    public func wipeStorage(completion: StorageCompletionHandler) {
        write(objects: [], completion: completion, block: { realm, _ in
            realm.deleteAll()
        })
    }
}
