//
//  StorageDatabaseManager.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import RealmSwift

public class StorageDatabaseManager: NSObject, StorageDatabase {
    // MARK: - Variables
    
    public static let sharedInstance = StorageDatabaseManager()
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
                print("can't creat realm object")
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
    
    func completionHandler(value: Bool, completion: StorageCompletionHandler) {
        DispatchQueue.main.async {
            completion?(value)
        }
    }
}

extension StorageDatabaseManager {
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
