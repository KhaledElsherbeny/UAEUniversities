//
//  StorageDatabaseManager.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

/// Manager responsible for storage database operations.
public class StorageDatabaseManager: NSObject, StorageDatabase {
    // MARK: - Variables
    
    /// Shared instance of `StorageDatabaseManager`.
    public static let sharedInstance = StorageDatabaseManager()
    
    /// The shared Realm instance.
    var sharedRealm: Realm?
    
    // MARK: - Init
    
    override init() {
        super.init()
        setupConfiguration()
        createRealmInstance()
    }
    
    private func createRealmInstance() {
        if sharedRealm == nil {
            do {
                sharedRealm = try Realm(configuration: Realm.Configuration.defaultConfiguration)
            } catch {
                print("can't create realm object")
            }
        }
    }
    
    /// Creates a new Realm instance.
    ///
    /// - Throws: An error if the Realm instance cannot be created.
    ///
    /// - Returns: A new Realm instance.
    private func createRealm() throws -> Realm {
        try Realm(configuration: Realm.Configuration.defaultConfiguration)
    }
    
    private func setupConfiguration() {
        let config = Realm.Configuration(
            deleteRealmIfMigrationNeeded: true
        )
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    /// Calls the completion handler on the main thread.
    ///
    /// - Parameters:
    ///   - value: The boolean value to pass to the completion handler.
    ///   - completion: The completion handler.
    func completionHandler(value: Bool, completion: StorageCompletionHandler) {
        DispatchQueue.main.async {
            completion?(value)
        }
    }
}

extension StorageDatabaseManager {
    /// Writes a single object to the database.
    ///
    /// - Parameters:
    ///   - object: The object to write to the database.
    ///   - completion: The completion handler called after the write operation.
    ///   - block: A block called after the write operation with the Realm instance and the resolved object.
    func write(
        object: Object,
        completion: StorageCompletionHandler,
        block: @escaping ((Realm, Object) -> Void)
    ) {
        guard let realm = sharedRealm else {
            completionHandler(value: false, completion: completion)
            return
        }
        
        realm.writeAsync(object, errorHandler: { [weak self] error in
            let status = error == nil ? true : false
            
            self?.completionHandler(value: status, completion: completion)
        }) { [weak self] realm, resolveObject in
            guard let resolveObject = resolveObject else {
                self?.completionHandler(value: false, completion: completion)
                return
            }
            
            block(realm, resolveObject)
        }
    }
    
    /// Writes an array of objects to the database.
    ///
    /// - Parameters:
    ///   - objects: The objects to write to the database.
    ///   - completion: The completion handler called after the write operation.
    ///   - block: A block called after the write operation with the Realm instance and the resolved objects.
    func write(
        objects: [Object],
        completion: StorageCompletionHandler,
        block: @escaping ((Realm, [Object]) -> Void)
    ) {
        guard let realm = sharedRealm else {
            completionHandler(value: false, completion: completion)
            return
        }
        
        realm.writeAsync(objects, errorHandler: { [weak self] error in
            let status = error == nil ? true : false
            
            self?.completionHandler(value: status, completion: completion)
        }) { [weak self] realm, resolveObject in
            guard let resolveObject = resolveObject else {
                self?.completionHandler(value: false, completion: completion)
                return
            }
            
            block(realm, resolveObject)
        }
    }
}
