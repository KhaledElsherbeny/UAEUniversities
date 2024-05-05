//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain
import StorageKit
import NetworkKit

final class UniversitiesListInteractor: UniversitiesListInteractorInputProtocol {
    weak var presenter: UniversitiesListInteractorOutputProtocol?
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol?
    var localDataManager: UniversitiesListLocalDataManagerInputProtocol?
    
    var countrySearchTerm: String = ""
    var universitiesListData = [UniversityListItem]()

    func updateCountrySearchTerm(country: String) {
        countrySearchTerm = country
    }
    
    func fetchUniversitiesList() {
        APIDataManager?.fetchUniversitiesList(country: countrySearchTerm) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let listItems):
                self.handleFetchSuccess(listItems: listItems)
            case .failure(let error):
                self.handleFetchFailure(error: error)
            }
        }
    }
    
    func refreshUniversitiesList() {
        universitiesListData = []
        presenter?.didSuccessFetchingUniversitiesList(items: [])

        localDataManager?.clearUniversitiesList(country: countrySearchTerm) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.fetchUniversitiesList()
            case .failure(let error):
                self.presenter?.didFaildFetchingUniversitiesList(error: error)
            }
        }
    }
}

extension UniversitiesListInteractor {
    private func handleFetchSuccess(listItems: [UniversityListItemDTO]) {
        let items = listItems.map { UniversityListItem(universityListItem: $0) }
        universitiesListData = items
        saveUniversitiesList(universityListItem: items)
        presenter?.didSuccessFetchingUniversitiesList(items: items)
    }

    private func handleFetchFailure(error: NetworkError) {
        fetchStoredUniversitiesList() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                if !items.isEmpty {
                    self.universitiesListData = items
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
        localDataManager?.saveUniversitiesList(list: itemsToSave, completion: { _ in })
    }
    
    private func fetchStoredUniversitiesList(completion: @escaping (Result<[UniversityListItem], StorageDatabaseError>)-> Void) {
        localDataManager?.fetchUniversitiesList(country: countrySearchTerm) { result in
            switch result {
            case .success(let storedItems):
                let items = storedItems.map({ UniversityListItem(universityListItem: $0)})
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
