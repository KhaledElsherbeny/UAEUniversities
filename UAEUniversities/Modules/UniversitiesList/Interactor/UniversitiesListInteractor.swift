//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

class UniversitiesListInteractor: UniversitiesListInteractorInputProtocol {
    weak var presenter: UniversitiesListInteractorOutputProtocol?
    var APIDataManager: UniversitiesListAPIDataManagerInputProtocol?
    var localDatamanager: UniversitiesListLocalDataManagerInputProtocol?
    
    init() {}
}
