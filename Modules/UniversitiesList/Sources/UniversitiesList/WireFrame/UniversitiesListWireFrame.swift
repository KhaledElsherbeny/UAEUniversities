//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import UniversityDetails
import Domain

/// Class responsible for wireframing in the universities list module.
public final class UniversitiesListWireFrame: UniversitiesListWireFrameProtocol {
    
    /// Weak reference to the view controller associated with the wireframe.
    weak var viewController: UIViewController?
    
    /// Creates a new instance of the universities list module.
    /// - Returns: The newly created instance of the universities list view.
    public static func createUniversitiesListModule() -> UniversitiesListView {
        // Generating module components
        let view = UniversitiesListView(nibName: "UniversitiesListView", bundle: .module)
        let presenter: UniversitiesListPresenterProtocol & UniversitiesListInteractorOutputProtocol = UniversitiesListPresenter()
        let interactor: UniversitiesListInteractorInputProtocol = UniversitiesListInteractor()
        let APIDataManager: UniversitiesListAPIDataManagerInputProtocol = UniversitiesListAPIDataManager()
        let localDataManager: UniversitiesListLocalDataManagerInputProtocol = UniversitiesListLocalDataManager()
        let wireFrame: UniversitiesListWireFrameProtocol = UniversitiesListWireFrame()
        
        // Connecting components
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
    
    /// Shows university details.
    /// - Parameters:
    ///   - universityItem: The university item to show details for.
    ///   - delegate: The delegate for handling refresh actions.
    func showDetails(for universityItem: UniversityListItem, delegate: UniversityDetailsOutputDelegate) {
        let detailsView = UniversityDetailsWireFrame.presentUniversityDetailsModule(with: universityItem, delegate: delegate)
        viewController?.navigationController?.pushViewController(detailsView, animated: true)
    }
}
