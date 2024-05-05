//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import Domain

public final class UniversityDetailsWireFrame: UniversityDetailsWireFrameProtocol {    
    weak var viewController: UIViewController?
    
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
    
    func dismiss() {
        if viewController?.navigationController != nil {
            viewController?.navigationController?.popViewController(animated: true)
        } else {
            viewController?.dismiss(animated: true)
        }
    }
}
