//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

/// Presenter for the universities list module.
final class UniversitiesListPresenter: UniversitiesListPresenterProtocol {
    
    /// Reference to the view.
    weak var view: UniversitiesListViewProtocol?
    /// Reference to the interactor.
    var interactor: UniversitiesListInteractorInputProtocol?
    /// Reference to the wireframe.
    var wireFrame: UniversitiesListWireFrameProtocol?
    
    /// The UI model representing the universities list.
    private lazy var universitiesListUIModel = [UniversityListItemUIModel]()
    
    /// Fetch universities list based on the provided country.
    /// - Parameter country: The country for which the universities list should be fetched.
    func fetchUniversitiesList(country: String) {
        view?.showLoadingView()
        interactor?.updateCountrySearchTerm(country: country)
        interactor?.fetchUniversitiesList()
    }
    
    /// Returns the number of items in the universities list.
    /// - Returns: The number of items in the universities list.
    func numberOfItems() -> Int {
        return universitiesListUIModel.count
    }
    
    /// Returns the university item at the specified index.
    /// - Parameter index: The index of the item to return.
    /// - Returns: The university item at the specified index.
    func item(at index: Int) -> UniversityListItemUIModel? {
        return universitiesListUIModel[index]
    }
    
    /// Notifies the presenter that the user selected an item at the specified index.
    /// - Parameter index: The index of the selected item.
    func didSelectItem(at index: Int) {
        guard let item = interactor?.universitiesListData[index] else { return }
        wireFrame?.showDetails(for: item, delegate: self)
    }
}

// MARK: - UniversitiesListInteractorOutputProtocol
extension UniversitiesListPresenter: UniversitiesListInteractorOutputProtocol  {
    /// Notifies the presenter that universities list fetching was successful.
    /// - Parameter items: The list of universities.
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem]) {
        universitiesListUIModel = items.map({ UniversityListItemUIModel(universityListItem: $0) })
        if items.isEmpty {
            view?.showEmptyStateView()
        } else {
            view?.hideEmptyStateView()
        }
        view?.updateView()
        view?.hideLoadingView()
    }
    
    /// Notifies the presenter that universities list fetching failed.
    /// - Parameter error: The error that occurred during fetching.
    func didFaildFetchingUniversitiesList(error: Error) {
        view?.hideLoadingView()
        view?.showError(error: error.localizedDescription)
    }
    
    /// Notifies the presenter that the universities list was cleared.
    func didClearUniversitiesList() {
        universitiesListUIModel.removeAll()
        view?.hideLoadingView()
        view?.updateView()
    }
}
