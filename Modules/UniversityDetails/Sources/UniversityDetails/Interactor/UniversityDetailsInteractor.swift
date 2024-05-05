//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation

final class UniversityDetailsInteractor: UniversityDetailsInteractorInputProtocol {
    weak var presenter: UniversityDetailsInteractorOutputProtocol?
    var APIDataManager: UniversityDetailsAPIDataManagerInputProtocol?
    var localDataManager: UniversityDetailsLocalDataManagerInputProtocol?
    
    init() {}
}
