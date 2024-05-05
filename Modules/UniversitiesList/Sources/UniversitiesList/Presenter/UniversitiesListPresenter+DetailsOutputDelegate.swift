//
//  UniversitiesListPresenter+DetailsOutputDelegate.swift
//
//
//  Created by Khalid on 05/05/2024.
//

import Foundation
import UniversityDetails

extension UniversitiesListPresenter: UniversityDetailsOutputDelegate {
    func didRefreshListView() {
        view?.showLoadingView()
        interactor?.refreshUniversitiesList()
    }
}
