//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import UniversityDetails
import Domain

public final class UniversitiesListWireFrame: UniversitiesListWireFrameProtocol {
    
    weak var viewController: UIViewController?
    
    public static func createUniversitiesListModule() -> UniversitiesListView {
        // Generating module components
        let view = UniversitiesListView(nibName: "UniversitiesListView", bundle: .module)
        let presenter: UniversitiesListPresenterProtocol & UniversitiesListInteractorOutputProtocol = UniversitiesListPresenter()
        let interactor: UniversitiesListInteractorInputProtocol = UniversitiesListInteractor()
        let APIDataManager: UniversitiesListAPIDataManagerInputProtocol = UniversitiesListAPIDataManager()
        let localDataManager: UniversitiesListLocalDataManagerInputProtocol = UniversitiesListLocalDataManager()
        let wireFrame: UniversitiesListWireFrameProtocol = UniversitiesListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDataManager = localDataManager
        wireFrame.viewController = view
        
        return view
    }
    
    func showDdetails(for universityItem: UniversityListItem, delegate: UniversityDetailsOutputDelegate) {
        let detailsView = UniversityDetailsWireFrame.presentUniversityDetailsModule(with: universityItem, delegate: delegate)
        viewController?.navigationController?.pushViewController(detailsView, animated: true)
    }
}
