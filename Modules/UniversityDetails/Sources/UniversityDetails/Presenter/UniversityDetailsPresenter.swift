//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

/// Presenter responsible for managing university details.
final class UniversityDetailsPresenter: UniversityDetailsPresenterProtocol, UniversityDetailsInteractorOutputProtocol {
    /// Weak reference to the view associated with the presenter.
    weak var view: UniversityDetailsViewProtocol?
    
    /// Reference to the interactor.
    var interactor: UniversityDetailsInteractorInputProtocol?
    
    /// Reference to the wireframe.
    var wireFrame: UniversityDetailsWireFrameProtocol?
    
    /// Weak reference to the delegate for handling refresh actions.
    weak var delegate: UniversityDetailsOutputDelegate?
    
    /// The university item to show details for.
    private let universityItem: UniversityListItem
    
    /// Initializes a new instance of UniversityDetailsPresenter.
    /// - Parameters:
    ///   - universityItem: The university item to show details for.
    ///   - delegate: The delegate for handling refresh actions.
    init(
        universityItem: UniversityListItem,
        delegate: UniversityDetailsOutputDelegate? = nil
    ) {
        self.universityItem = universityItem
        self.delegate = delegate
    }
    
    /// Called when the view is loaded.
    func viewDidLoad() {
        view?.updateView(with: universityItem)
    }
    
    /// Called when the refresh button is tapped.
    func didTapRefresh() {
        wireFrame?.dismiss()
        delegate?.didRefreshListView()
    }
}
