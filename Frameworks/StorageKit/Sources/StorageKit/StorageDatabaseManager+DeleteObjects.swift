//
//  StorageDatabaseManager+DeleteObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

extension StorageDatabaseManager {
    public func delete(objects type: StorageDatabaseType.Type, completion: StorageCompletionHandler) {
        guard let objects = get(objects: type) else {
            completionHandler(value: false, completion: completion)
            return
        }

        delete(objects: objects, completion: completion)
    }

    public func delete(object type: StorageDatabaseType.Type, completion: StorageCompletionHandler) {
        guard let object = get(object: type) else {
            completionHandler(value: false, completion: completion)
            return
        }

        delete(object: object, completion: completion)
    }

    public func delete(objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        write(objects: objects, completion: completion, block: { realm, _ in
            if let object = objects.first {
                let type = type(of: object)
                let result = realm.objects(type)
                realm.delete(result)
            }
        })
    }

    public func delete(object: StorageDatabaseType, completion: StorageCompletionHandler) {
        write(object: object, completion: completion, block: { realm, resolveObjects in
            realm.delete(resolveObjects)
        })
    }
}
