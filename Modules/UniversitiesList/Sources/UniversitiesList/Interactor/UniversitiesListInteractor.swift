//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain
import StorageKit
import NetworkKit

class UniversitiesListInteractor: UniversitiesListInteractorInputProtocol {
    weak var presenter: UniversitiesListInteractorOutputProtocol?
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol?
    var localDatamanager: UniversitiesListLocalDataManagerInputProtocol?
    
    func fetchUniversitiesList(country: String) {
        APIDataManager?.fetchUniversitiesList(contry: country) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listItems):
                self.handleFetchSuccess(listItems: listItems)
            case .failure(let error):
                self.handleFetchFailure(country: country, error: error)
            }
        }
    }

    private func handleFetchSuccess(listItems: [UniversityListItemDTO]) {
        let items = listItems.map { UniversityListItem(universityListItem: $0) }
        saveUniversitiesList(universityListItem: items)
        presenter?.didSuccessFetchingUniversitiesList(items: items)
    }

    private func handleFetchFailure(country: String, error: NetworkError) {
        fetchStoredUniversitiesList(country: country) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                if !items.isEmpty {
                    self.presenter?.didSuccessFetchingUniversitiesList(items: items)
                } else {
                    self.presenter?.didFaildFetchingUniversitiesList(error: error)
                }
            case .failure(let error):
                self.presenter?.didFaildFetchingUniversitiesList(error: error)
            }
        }
    }
}

extension UniversitiesListInteractor {
    private func saveUniversitiesList(universityListItem: [UniversityListItem]) {
        let itemsToSave = universityListItem.map({ UniversityListItemRealm(universityListItem: $0) })
        localDatamanager?.saveUniversitiesList(list: itemsToSave, completion: { _ in })
    }
    
    private func fetchStoredUniversitiesList(
        country: String,
        completion: @escaping (Result<[UniversityListItem], StorageDatabaseError>)-> Void
    ) {
        localDatamanager?.fetchUniversitiesList(contry: country) { result in
            switch result {
            case .success(let storedIems):
                let items = storedIems.map({ UniversityListItem(universityListItem: $0)})
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
