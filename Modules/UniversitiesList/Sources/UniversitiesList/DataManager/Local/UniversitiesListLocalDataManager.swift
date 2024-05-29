//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import StorageKit

/// Local data manager responsible for managing local storage related operations for university list.
final class UniversitiesListLocalDataManager: UniversitiesListLocalDataManagerInputProtocol {
    
    /// Storage manager responsible for handling local storage operations.
    var storageManager: StorageDatabase = StorageDatabaseManager.sharedInstance
    
    /// Fetches the list of universities from local storage.
    ///
    /// - Parameters:
    ///   - country: The country for which the list of universities is to be fetched.
    ///   - completion: A closure to be executed when the fetch operation finishes. It returns a result containing either the list of universities or a storage database error.
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
    
    /// Saves the list of universities to local storage.
    ///
    /// - Parameters:
    ///   - list: The list of universities to be saved.
    ///   - completion: A closure to be executed when the save operation finishes. It returns a result indicating whether the operation was successful or a storage database error occurred.
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
    
    /// Clears the list of universities for a specific country from local storage.
    ///
    /// - Parameters:
    ///   - country: The country for which the list of universities is to be cleared.
    ///   - completion: A closure to be executed when the clear operation finishes. It returns a result indicating whether the operation was successful or a storage database error occurred.
    func clearUniversitiesList(
        country: String,
        completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void
    ) {
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
