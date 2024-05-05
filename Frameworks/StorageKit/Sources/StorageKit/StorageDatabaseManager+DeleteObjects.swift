//
//  StorageDatabaseManager+DeleteObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

/// Manages delete operations.
extension StorageDatabaseManager {
    /// Deletes objects of a specified type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of objects to delete.
    ///   - completion: The completion handler called after the delete operation.
    public func delete(objects type: StorageDatabaseType.Type, completion: StorageCompletionHandler) {
        guard let objects = get(objects: type) else {
            completionHandler(value: false, completion: completion)
            return
        }

        delete(objects: objects, completion: completion)
    }

    /// Deletes an object of a specified type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of object to delete.
    ///   - completion: The completion handler called after the delete operation.
    public func delete(object type: StorageDatabaseType.Type, completion: StorageCompletionHandler) {
        guard let object = get(object: type) else {
            completionHandler(value: false, completion: completion)
            return
        }

        delete(object: object, completion: completion)
    }

    /// Deletes the specified objects from the database.
    ///
    /// - Parameters:
    ///   - objects: The objects to delete.
    ///   - completion: The completion handler called after the delete operation.
    public func delete(objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        write(objects: objects, completion: completion, block: { realm, _ in
            if let object = objects.first {
                let type = type(of: object)
                let result = realm.objects(type)
                realm.delete(result)
            }
        })
    }

    /// Deletes the specified object from the database.
    ///
    /// - Parameters:
    ///   - object: The object to delete.
    ///   - completion: The completion handler called after the delete operation.
    public func delete(object: StorageDatabaseType, completion: StorageCompletionHandler) {
        write(object: object, completion: completion, block: { realm, resolveObjects in
            realm.delete(resolveObjects)
        })
    }
}
