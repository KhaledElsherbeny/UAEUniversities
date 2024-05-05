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

protocol UniversitiesListViewProtocol: AnyObject {
    var presenter: UniversitiesListPresenterProtocol? { get set }
    
    func updateView()
    func showError(error: String)

    func showEmptyStateView()
    func hideEmptyStateView()
    
    func showLoadingView()
    func hideLoadingView()
}

protocol UniversitiesListWireFrameProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createUniversitiesListModule() -> UniversitiesListView
    
    func showDdetails(for universityItem: UniversityListItem, delegate: UniversityDetailsOutputDelegate)
}

protocol UniversitiesListPresenterProtocol: AnyObject {
    var view: UniversitiesListViewProtocol? { get set }
    var interactor: UniversitiesListInteractorInputProtocol? { get set }
    var wireFrame: UniversitiesListWireFrameProtocol? { get set }

    func fetchUniversitiesList(country: String)

    func numberOfItems() -> Int
    func item(at index: Int) -> UniversityListItemUIModel?
    func didSelectItem(at index: Int)
}

protocol UniversitiesListInteractorOutputProtocol: AnyObject {
    func didClearUniversitiesList()
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem])
    func didFaildFetchingUniversitiesList(error: Error)
}

protocol UniversitiesListInteractorInputProtocol: AnyObject {
    var presenter: UniversitiesListInteractorOutputProtocol? { get set }
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol? { get set }
    var localDataManager: UniversitiesListLocalDataManagerInputProtocol? { get set }
    
    var countrySearchTerm: String { get set }
    var universitiesListData: [UniversityListItem] { get set }

    func updateCountrySearchTerm(country: String)
    func fetchUniversitiesList()
    func refreshUniversitiesList()
}

protocol UniversitiesListAPIDataManagerInputProtocol: AnyObject {
    func fetchUniversitiesList(country: String, completion: @escaping (Result<[UniversityListItemDTO], NetworkError>)-> Void)
}

protocol UniversitiesListLocalDataManagerInputProtocol: AnyObject {
    func saveUniversitiesList(list: [UniversityListItemRealm], completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void)
    func fetchUniversitiesList(country: String, completion: @escaping (Result<[UniversityListItemRealm], StorageDatabaseError>)-> Void)
    func clearUniversitiesList(country: String, completion: @escaping (Result<Bool, StorageDatabaseError>)-> Void)
}
