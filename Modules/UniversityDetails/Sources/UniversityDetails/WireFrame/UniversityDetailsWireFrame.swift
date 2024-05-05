//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import Domain

/// Wireframe responsible for presenting the university details module.
public final class UniversityDetailsWireFrame: UniversityDetailsWireFrameProtocol {
    /// Reference to the view controller.
    weak var viewController: UIViewController?
    
    /// Presents the university details module.
    /// - Parameters:
    ///   - universityItem: The university item to display details for.
    ///   - delegate: The delegate for handling events from the details module.
    /// - Returns: The view controller of the university details module.
    public static func presentUniversityDetailsModule(
        with universityItem: UniversityListItem,
        delegate: UniversityDetailsOutputDelegate?
    ) -> UIViewController {
        // Generating module components
        let view = UniversityDetailsView(nibName: "UniversityDetailsView", bundle: .module)
        let presenter: UniversityDetailsPresenterProtocol & UniversityDetailsInteractorOutputProtocol = UniversityDetailsPresenter(universityItem: universityItem, delegate: delegate)
        let interactor: UniversityDetailsInteractorInputProtocol = UniversityDetailsInteractor()
        let APIDataManager: UniversityDetailsAPIDataManagerInputProtocol = UniversityDetailsAPIDataManager()
        let localDataManager: UniversityDetailsLocalDataManagerInputProtocol = UniversityDetailsLocalDataManager()
        let wireFrame: UniversityDetailsWireFrameProtocol = UniversityDetailsWireFrame()
        
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
    
    /// Dismisses the university details module.
    public func dismiss() {
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
}
