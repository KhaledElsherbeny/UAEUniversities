//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import StorageKit

final class UniversitiesListLocalDataManager: UniversitiesListLocalDataManagerInputProtocol {

    var storageManager: StorageDatabase = StorageDatabaseManager.sharedInstance
    
    func fetchUniversitiesList(
        country: String,
        completion: @escaping (Result<[UniversityListItemRealm], StorageDatabaseError>)-> Void
    ) {
        let predicate = NSPredicate(format: "country = %@", country)
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
    
    func clearUniversitiesList(country: String, completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void) {
        fetchUniversitiesList(country: country) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.storageManager.delete(objects: items) { success in
                    success ? completion(.success(true)) : completion(.failure(.databaseWriteError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
