//
//  StorageDatabase.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import RealmSwift
import Foundation

public typealias StorageCompletionHandler = ((Bool) -> Void)?
public typealias StorageBlockHandler = (() -> Void)?
public typealias StorageDatabaseType = Object

public protocol StorageDatabase {
    func save(object: StorageDatabaseType, completion: StorageCompletionHandler)
    func save(objectWithPrimaryKey object: StorageDatabaseType, completion: StorageCompletionHandler)
    func save(objects: [StorageDatabaseType], completion: StorageCompletionHandler)
    func save(objectsWithPrimaryKey objects: [StorageDatabaseType], completion: StorageCompletionHandler)

    func get(objects type: StorageDatabaseType.Type) -> [StorageDatabaseType]?
    func get(object type: StorageDatabaseType.Type) -> StorageDatabaseType?
    func get(objectsWithQuery type: StorageDatabaseType.Type, predicate: NSPredicate) -> [StorageDatabaseType]?

    func delete(objects type: StorageDatabaseType.Type, completion: StorageCompletionHandler)
    func delete(object type: StorageDatabaseType.Type, completion: StorageCompletionHandler)
    func delete(objects: [StorageDatabaseType], completion: StorageCompletionHandler)
    func delete(object: StorageDatabaseType, completion: StorageCompletionHandler)
    
    func wipeStorage(completion: StorageCompletionHandler)
}
