//
//  StorageDatabaseManager+FetchObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

/// Manages read operations.
extension StorageDatabaseManager {
    /// Retrieves objects of a specified type from the database.
    ///
    /// - Parameter type: The type of objects to retrieve.
    /// - Returns: An array of objects of the specified type, if found; otherwise, nil.
    public func get(objects type: StorageDatabaseType.Type) -> [StorageDatabaseType]? {
        guard let results = getObjects(type) else {
            return nil
        }
        var objects = [Object]()
        for result: Object in results {
            objects.append(result)
        }
        if objects.count > 0 {
            return objects
        }
        return nil
    }
    
    /// Retrieves an object of a specified type from the database.
    ///
    /// - Parameter type: The type of object to retrieve.
    /// - Returns: An object of the specified type, if found; otherwise, nil.
    public func get(object type: StorageDatabaseType.Type) -> StorageDatabaseType? {
        guard let results = getObjects(type) else {
            return nil
        }
        var storageObject: Object?
        for result: Object in results {
            storageObject = Object()
            storageObject = result
            break
        }
        return storageObject
    }
    
    /// Retrieves objects of a specified type from the database that match the specified predicate.
    ///
    /// - Parameters:
    ///   - type: The type of objects to retrieve.
    ///   - predicate: The predicate to filter the objects.
    /// - Returns: An array of objects of the specified type that match the predicate, if found; otherwise, nil.
    public func get(objectsWithQuery type: StorageDatabaseType.Type, predicate: NSPredicate) -> [StorageDatabaseType]? {
        guard let results = getObjects(type) else {
            return nil
        }
        let result: Results<Object> = results.filter(predicate)
        var objects = [Object]()
        for object: Object in result {
            objects.append(object)
        }
        if objects.count > 0 {
            return objects
        }
        return nil
    }
    
    private func getObjects(_ type: StorageDatabaseType.Type) -> Results<StorageDatabaseType>? {
        return sharedRealm?.objects(type)
    }
}
