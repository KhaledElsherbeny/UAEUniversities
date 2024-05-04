//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

class UniversitiesListInteractor: UniversitiesListInteractorInputProtocol {
    weak var presenter: UniversitiesListInteractorOutputProtocol?
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol?
    var localDatamanager: UniversitiesListLocalDataManagerInputProtocol?
        
    func fetchUniversitiesList(country: String) {
        APIDataManager?.fetchUniversitiesList(contry: country) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let itemsResponse):
                let items = itemsResponse.map({ UniversityListItem(universityListItemDTO: $0) })
                self.presenter?.didSuccessFetchingUniversitiesList(items: items)
            case .failure(let error):
                self.presenter?.didFaildFetchingUniversitiesList(error: error)
            }
        }
    }
}
