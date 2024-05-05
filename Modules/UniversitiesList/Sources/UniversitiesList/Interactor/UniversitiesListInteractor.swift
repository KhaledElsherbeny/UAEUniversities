//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain
import StorageKit
import NetworkKit

/// Interactor responsible for managing university list.
final class UniversitiesListInteractor: UniversitiesListInteractorInputProtocol {
    
    weak var presenter: UniversitiesListInteractorOutputProtocol?
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol?
    var localDataManager: UniversitiesListLocalDataManagerInputProtocol?
    
    /// The search term for country.
    var countrySearchTerm: String = ""
    
    /// List of university items.
    var universitiesListData = [UniversityListItem]()
    
    /// Updates the search term for country.
    ///
    /// - Parameter country: The search term for country.
    func updateCountrySearchTerm(country: String) {
        countrySearchTerm = country
    }
    
    /// Fetches the list of universities.
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
    
    /// Refreshes the list of universities.
    func refreshUniversitiesList() {
        universitiesListData = []
        presenter?.didClearUniversitiesList()

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

// MARK: - Private Methods
extension UniversitiesListInteractor {
    /// Handles successful fetch of university list.
    ///
    /// - Parameter listItems: List of university items.
    private func handleFetchSuccess(listItems: [UniversityListItemDTO]) {
        let items = listItems.map { UniversityListItem(universityListItem: $0) }
        universitiesListData = items
        saveUniversitiesList(universityListItem: items)
        presenter?.didSuccessFetchingUniversitiesList(items: items)
    }

    /// Handles failed fetch of university list.
    ///
    /// - Parameter error: The error occurred during fetch.
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

// MARK: - Private Methods
extension UniversitiesListInteractor {
    /// Saves the list of universities locally.
    ///
    /// - Parameter universityListItem: List of university items.
    private func saveUniversitiesList(universityListItem: [UniversityListItem]) {
        let itemsToSave = universityListItem.map({ UniversityListItemRealm(universityListItem: $0) })
        localDataManager?.saveUniversitiesList(list: itemsToSave, completion: { _ in })
    }
    
    /// Fetches stored universities list from local storage.
    ///
    /// - Parameter completion: Completion block returning the result of fetch operation.
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
