//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

final class UniversitiesListPresenter: UniversitiesListPresenterProtocol {
    
    weak var view: UniversitiesListViewProtocol?
    var interactor: UniversitiesListInteractorInputProtocol?
    var wireFrame: UniversitiesListWireFrameProtocol?
        
    private lazy var universitiesListUIModel = [UniversityListItemUIModel]()
        
    func fetchUniversitiesList(country: String) {
        view?.showLoadingView()
        interactor?.updateCountrySearchTerm(country: country)
        interactor?.fetchUniversitiesList()
    }
    
    func numberOfItems() -> Int {
        return universitiesListUIModel.count
    }
    
    func item(at index: Int) -> UniversityListItemUIModel? {
        return universitiesListUIModel[index]
    }
    
    func didSelectItem(at index: Int) {
        guard let item = interactor?.universitiesListData[index] else { return }
        wireFrame?.showDdetails(for: item, delegate: self)
    }
}

extension UniversitiesListPresenter: UniversitiesListInteractorOutputProtocol  {
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem]) {
        universitiesListUIModel = items.map({ UniversityListItemUIModel(universityListItem: $0) })
        view?.updateView()
        view?.hideEmptyStateView()
    }
    
    func didFaildFetchingUniversitiesList(error: Error) {
        view?.showError(error: error.localizedDescription)
    }
}
