//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

final class UniversitiesListPresenter: UniversitiesListPresenterProtocol, UniversitiesListInteractorOutputProtocol {
    weak var view: UniversitiesListViewProtocol?
    var interactor: UniversitiesListInteractorInputProtocol?
    var wireFrame: UniversitiesListWireFrameProtocol?
    
    init() {}
}
