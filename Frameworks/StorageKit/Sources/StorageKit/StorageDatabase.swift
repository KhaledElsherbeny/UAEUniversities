//
//  StorageDatabase.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import RealmSwift
import Foundation

/// A typealias for the completion handler used in storage operations.
public typealias StorageCompletionHandler = ((Bool) -> Void)?

/// A typealias for the block handler used in storage operations.
public typealias StorageBlockHandler = (() -> Void)?

/// A typealias representing the type of database object.
public typealias StorageDatabaseType = Object

/// A protocol defining functionalities for interacting with a storage database.
public protocol StorageDatabase {
    /// Saves an object to the database.
    ///
    /// - Parameters:
    ///   - object: The object to be saved.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func save(object: StorageDatabaseType, completion: StorageCompletionHandler)
    
    /// Saves an object to the database with a primary key.
    ///
    /// - Parameters:
    ///   - object: The object to be saved.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func save(objectWithPrimaryKey object: StorageDatabaseType, completion: StorageCompletionHandler)
    
    /// Saves an array of objects to the database.
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be saved.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func save(objects: [StorageDatabaseType], completion: StorageCompletionHandler)
    
    /// Saves an array of objects to the database with primary keys.
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be saved.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func save(objectsWithPrimaryKey objects: [StorageDatabaseType], completion: StorageCompletionHandler)

    /// Retrieves all objects of a given type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of objects to retrieve.
    /// - Returns: An array of objects of the specified type, or nil if no objects are found.
    func get(objects type: StorageDatabaseType.Type) -> [StorageDatabaseType]?
    
    /// Retrieves a single object of a given type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of object to retrieve.
    /// - Returns: The retrieved object of the specified type, or nil if no object is found.
    func get(object type: StorageDatabaseType.Type) -> StorageDatabaseType?
    
    /// Retrieves objects of a given type from the database based on a predicate.
    ///
    /// - Parameters:
    ///   - type: The type of objects to retrieve.
    ///   - predicate: The predicate to filter objects.
    /// - Returns: An array of objects of the specified type, filtered by the predicate, or nil if no objects are found.
    func get(objectsWithQuery type: StorageDatabaseType.Type, predicate: NSPredicate) -> [StorageDatabaseType]?

    /// Deletes all objects of a given type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of objects to delete.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func delete(objects type: StorageDatabaseType.Type, completion: StorageCompletionHandler)
    
    /// Deletes a single object of a given type from the database.
    ///
    /// - Parameters:
    ///   - type: The type of object to delete.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func delete(object type: StorageDatabaseType.Type, completion: StorageCompletionHandler)
    
    /// Deletes an array of objects from the database.
    ///
    /// - Parameters:
    ///   - objects: The array of objects to delete.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func delete(objects: [StorageDatabaseType], completion: StorageCompletionHandler)
    
    /// Deletes a single object from the database.
    ///
    /// - Parameters:
    ///   - object: The object to delete.
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func delete(object: StorageDatabaseType, completion: StorageCompletionHandler)
    
    /// Clears the storage database.
    ///
    /// - Parameters:
    ///   - completion: A closure to be executed when the operation completes. It returns a boolean value indicating whether the operation was successful.
    func wipeStorage(completion: StorageCompletionHandler)
}
