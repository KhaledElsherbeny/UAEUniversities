//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import Foundation
import Domain
import StorageKit
import NetworkKit
import UniversityDetails

/// Protocol defining the interface for the view of the universities list.
protocol UniversitiesListViewProtocol: AnyObject {
    /// The presenter for the universities list view.
    var presenter: UniversitiesListPresenterProtocol? { get set }
    
    /// Updates the view.
    func updateView()
    
    /// Shows an error message.
    /// - Parameter error: The error message to show.
    func showError(error: String)

    /// Shows an empty state view.
    func showEmptyStateView()
    
    /// Hides the empty state view.
    func hideEmptyStateView()
    
    /// Shows the loading view.
    func showLoadingView()
    
    /// Hides the loading view.
    func hideLoadingView()
}

/// Protocol defining the interface for the wireframe of the universities list module.
protocol UniversitiesListWireFrameProtocol: AnyObject {
    /// The view controller associated with the wireframe.
    var viewController: UIViewController? { get set }
    
    /// Creates a new instance of the universities list module.
    static func createUniversitiesListModule() -> UniversitiesListView
    
    /// Shows university details.
    /// - Parameters:
    ///   - universityItem: The university item to show details for.
    ///   - delegate: The delegate for handling refresh actions.
    func showDetails(for universityItem: UniversityListItem, delegate: UniversityDetailsOutputDelegate)
}

/// Protocol defining the interface for the presenter of the universities list.
protocol UniversitiesListPresenterProtocol: AnyObject {
    /// The view associated with the presenter.
    var view: UniversitiesListViewProtocol? { get set }
    
    /// The interactor associated with the presenter.
    var interactor: UniversitiesListInteractorInputProtocol? { get set }
    
    /// The wireframe associated with the presenter.
    var wireFrame: UniversitiesListWireFrameProtocol? { get set }

    /// Fetches universities list for a given country.
    /// - Parameter country: The country to fetch universities list for.
    func fetchUniversitiesList(country: String)

    /// Returns the number of items in the universities list.
    func numberOfItems() -> Int
    
    /// Returns the university list item at the specified index.
    /// - Parameter index: The index of the university list item.
    func item(at index: Int) -> UniversityListItemUIModel?
    
    /// Handles the selection of a university list item.
    /// - Parameter index: The index of the selected item.
    func didSelectItem(at index: Int)
}

/// Protocol defining the interface for the interactor of the universities list.
protocol UniversitiesListInteractorInputProtocol: AnyObject {
    /// The presenter associated with the interactor.
    var presenter: UniversitiesListInteractorOutputProtocol? { get set }
    
    /// The API data manager associated with the interactor.
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol? { get set }
    
    /// The local data manager associated with the interactor.
    var localDataManager: UniversitiesListLocalDataManagerInputProtocol? { get set }
    
    /// The search term for filtering universities.
    var countrySearchTerm: String { get set }
    
    /// The data for universities list.
    var universitiesListData: [UniversityListItem] { get set }

    /// Updates the country search term.
    /// - Parameter country: The country to set as search term.
    func updateCountrySearchTerm(country: String)
    
    /// Fetches universities list.
    func fetchUniversitiesList()
    
    /// Refreshes universities list.
    func refreshUniversitiesList()
}

/// Protocol defining the interface for the output of the universities list interactor.
protocol UniversitiesListInteractorOutputProtocol: AnyObject {
    /// Notifies that universities list is cleared.
    func didClearUniversitiesList()
    
    /// Notifies that universities list is successfully fetched.
    /// - Parameter items: The list of university items.
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem])
    
    /// Notifies that an error occurred while fetching universities list.
    /// - Parameter error: The error occurred while fetching universities list.
    func didFaildFetchingUniversitiesList(error: Error)
}

/// Protocol defining the interface for the API data manager of the universities list.
protocol UniversitiesListAPIDataManagerInputProtocol: AnyObject {
    /// Fetches universities list from the API.
    /// - Parameters:
    ///   - country: The country to fetch universities list for.
    ///   - completion: The completion block to be executed when the request is completed.
    func fetchUniversitiesList(country: String, completion: @escaping (Result<[UniversityListItemDTO], NetworkError>)-> Void)
}

/// Protocol defining the interface for the local data manager of the universities list.
protocol UniversitiesListLocalDataManagerInputProtocol: AnyObject {
    /// Saves universities list to local storage.
    /// - Parameters:
    ///   - list: The list of universities to be saved.
    ///   - completion: The completion block to be executed when the operation is completed.
    func saveUniversitiesList(list: [UniversityListItemRealm], completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void)
    
    /// Fetches universities list from local storage.
    /// - Parameters:
    ///   - country: The country to fetch universities list for.
    ///   - completion: The completion block to be executed when the operation is completed.
    func fetchUniversitiesList(country: String, completion: @escaping (Result<[UniversityListItemRealm], StorageDatabaseError>)-> Void)
    
    /// Clears universities list from local storage.
    /// - Parameters:
    ///   - country: The country to clear universities list for.
    ///   - completion: The completion block to be executed when the operation is completed.
    func clearUniversitiesList(country: String, completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void)
}
