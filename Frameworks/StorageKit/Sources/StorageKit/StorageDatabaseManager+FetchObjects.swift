//
//  StorageDatabaseManager+FetchObjects.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

extension StorageDatabaseManager {
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
