//
//  StorageDatabaseManager+SaveObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

extension StorageDatabaseManager {
    public func save(object: StorageDatabaseType, completion: StorageCompletionHandler) {
        write(objects: [object], completion: completion, block: { realm, resolveObjects in
            realm.add(resolveObjects, update: .all)
        })
    }

    public func save(objectWithPrimaryKey object: StorageDatabaseType, completion: StorageCompletionHandler) {
        save(object: object, completion: completion)
    }

    public func save(objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        write(objects: objects, completion: completion, block: { realm, resolveObjects in
            realm.add(resolveObjects, update: .all)
        })
    }

    public func save(objectsWithPrimaryKey objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        save(objects: objects, completion: completion)
    }
}
