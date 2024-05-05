//
//  UniversitiesListPresenter+DetailsOutputDelegate.swift
//
//
//  Created by Khalid on 05/05/2024.
//

import Foundation
import UniversityDetails

// MARK: - UniversityDetailsOutputDelegate
extension UniversitiesListPresenter: UniversityDetailsOutputDelegate {
    /// Notifies the presenter that the list view needs to be refreshed.
    func didRefreshListView() {
        view?.showLoadingView()
        interactor?.refreshUniversitiesList()
    }
}
