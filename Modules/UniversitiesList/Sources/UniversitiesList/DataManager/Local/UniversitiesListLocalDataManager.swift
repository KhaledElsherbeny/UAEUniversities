//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import StorageKit

final class UniversitiesListLocalDataManager: UniversitiesListLocalDataManagerInputProtocol {

    var storageManager: StorageDatabase = StorageDatabaseManager.sharedInstance
    
    func fetchUniversitiesList(
        contry: String,
        completion: @escaping (Result<[UniversityListItemRealm], StorageDatabaseError>)-> Void
    ) {
        let predicate = NSPredicate(format: "country = %@", contry)
        let results = storageManager.get(
            objectsWithQuery: UniversityListItemRealm.self,
            predicate: predicate
        ) as? [UniversityListItemRealm]
        completion(.success(results ?? []))
    }
    
    func saveUniversitiesList(
        list: [UniversityListItemRealm],
        completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void
    ) {
        storageManager.save(objects: list) { success in
            if success {
                completion(.success(true))
            } else {
                completion(.failure(.databaseWriteError))
            }
        }
    }
}
