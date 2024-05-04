//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

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
    static func createUniversitiesListModule() -> UniversitiesListView
}

protocol UniversitiesListPresenterProtocol: AnyObject {
    var view: UniversitiesListViewProtocol? { get set }
    var interactor: UniversitiesListInteractorInputProtocol? { get set }
    var wireFrame: UniversitiesListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func item(at index: Int) -> UniversityListItemUIModel?
}

protocol UniversitiesListInteractorOutputProtocol: AnyObject {
    func didSuccessFetchingUniversitiesList(items: [UniversityListItem])
    func didFaildFetchingUniversitiesList(error: Error)
}

protocol UniversitiesListInteractorInputProtocol: AnyObject {
    var presenter: UniversitiesListInteractorOutputProtocol? { get set }
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol? { get set }
    var localDatamanager: UniversitiesListLocalDataManagerInputProtocol? { get set }
    
    func fetchUniversitiesList(country: String)
}

protocol UniversitiesListAPIDataManagerInputProtocol: AnyObject {
    func fetchUniversitiesList(contry: String, completion: @escaping (Result<[UniversitiesListItem], Error>)-> Void)
}

protocol UniversitiesListLocalDataManagerInputProtocol: AnyObject {
    func fetchUniversitiesList(contry: String, completion: @escaping (Result<[UniversitiesListItem], Error>)-> Void)
}
