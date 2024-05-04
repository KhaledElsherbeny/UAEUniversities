//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

public final class UniversitiesListWireFrame: UniversitiesListWireFrameProtocol {
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
        interactor.localDatamanager = localDataManager
        
        return view
    }
}
