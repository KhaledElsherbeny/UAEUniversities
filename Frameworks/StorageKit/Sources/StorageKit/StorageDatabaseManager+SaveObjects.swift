//
//  StorageDatabaseManager+SaveObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

/// Manages saving operations.
extension StorageDatabaseManager {
    /// Saves an object to the database.
    ///
    /// - Parameters:
    ///   - object: The object to be saved.
    ///   - completion: The completion handler to be called after saving the object.
    public func save(object: StorageDatabaseType, completion: StorageCompletionHandler) {
        write(objects: [object], completion: completion, block: { realm, resolveObjects in
            realm.add(resolveObjects, update: .all)
        })
    }

    /// Saves an object with a primary key to the database.
    ///
    /// - Parameters:
    ///   - object: The object with a primary key to be saved.
    ///   - completion: The completion handler to be called after saving the object.
    public func save(objectWithPrimaryKey object: StorageDatabaseType, completion: StorageCompletionHandler) {
        save(object: object, completion: completion)
    }

    /// Saves an array of objects to the database.
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be saved.
    ///   - completion: The completion handler to be called after saving the objects.
    public func save(objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        write(objects: objects, completion: completion, block: { realm, resolveObjects in
            realm.add(resolveObjects, update: .all)
        })
    }

    /// Saves an array of objects with primary keys to the database.
    ///
    /// - Parameters:
    ///   - objects: The array of objects with primary keys to be saved.
    ///   - completion: The completion handler to be called after saving the objects.
    public func save(objectsWithPrimaryKey objects: [StorageDatabaseType], completion: StorageCompletionHandler) {
        save(objects: objects, completion: completion)
    }
}
