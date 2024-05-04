//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

final class UniversitiesListPresenter: UniversitiesListPresenterProtocol {
    
    weak var view: UniversitiesListViewProtocol?
    var interactor: UniversitiesListInteractorInputProtocol?
    var wireFrame: UniversitiesListWireFrameProtocol?
    
    lazy var universitiesList = [UniversityListItemUIModel]()
    
    init() {}
    
    func viewDidLoad() {
        fetchUniversitiesList()
    }
    
    private func fetchUniversitiesList() {
        view?.showLoadingView()
        interactor?.fetchUniversitiesList(country: "United Arab Emirates")
    }
    
    func numberOfItems() -> Int {
        return universitiesList.count
    }
    
    func item(at index: Int) -> UniversityListItemUIModel? {
        return universitiesList[index]
    }
}

extension UniversitiesListPresenter: UniversitiesListInteractorOutputProtocol  {
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem]) {
        universitiesList = items.map({ UniversityListItemUIModel(universityListItem: $0) })
        view?.updateView()
        view?.hideEmptyStateView()
    }
    
    func didFaildFetchingUniversitiesList(error: Error) {
        view?.showError(error: error.localizedDescription)
    }
}
