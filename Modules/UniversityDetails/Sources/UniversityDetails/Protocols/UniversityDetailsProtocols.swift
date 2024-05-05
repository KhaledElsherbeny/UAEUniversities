//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import Domain

/// Delegate for handling refresh actions in university details.
public protocol UniversityDetailsOutputDelegate: AnyObject {
    /// Informs the delegate that the list view needs to be refreshed.
    func didRefreshListView()
}

/// Protocol defining the required behavior for the university details view.
protocol UniversityDetailsViewProtocol: AnyObject {
    /// Reference to the presenter.
    var presenter: UniversityDetailsPresenterProtocol? { get set }
    
    /// Updates the view with the provided university item.
    /// - Parameter universityItem: The university item to display.
    func updateView(with universityItem: UniversityListItem)
}

/// Protocol defining the required behavior for the university details wireframe.
protocol UniversityDetailsWireFrameProtocol: AnyObject {
    /// Reference to the view controller associated with the wireframe.
    var viewController: UIViewController? { get set }

    /// Presents the university details module.
    /// - Parameters:
    ///   - universityItem: The university item to display details for.
    ///   - delegate: The delegate for handling refresh actions.
    static func presentUniversityDetailsModule(
        with universityItem: UniversityListItem,
        delegate: UniversityDetailsOutputDelegate?
    ) -> UIViewController
    
    /// Dismisses the university details module.
    func dismiss()
}

/// Protocol defining the required behavior for the university details presenter.
protocol UniversityDetailsPresenterProtocol: AnyObject {
    /// Reference to the view associated with the presenter.
    var view: UniversityDetailsViewProtocol? { get set }
    
    /// Reference to the interactor.
    var interactor: UniversityDetailsInteractorInputProtocol? { get set }
    
    /// Reference to the wireframe.
    var wireFrame: UniversityDetailsWireFrameProtocol? { get set }
    
    /// Called when the view is loaded.
    func viewDidLoad()
    
    /// Called when the refresh button is tapped.
    func didTapRefresh()
}

/// Protocol defining the required behavior for the university details interactor.
protocol UniversityDetailsInteractorOutputProtocol: AnyObject { }

/// Protocol defining the required behavior for the university details interactor input.
protocol UniversityDetailsInteractorInputProtocol: AnyObject {
    /// Reference to the interactor output.
    var presenter: UniversityDetailsInteractorOutputProtocol? { get set }
    
    /// Reference to the API data manager.
    var APIDataManager: UniversityDetailsAPIDataManagerInputProtocol? { get set }
    
    /// Reference to the local data manager.
    var localDataManager: UniversityDetailsLocalDataManagerInputProtocol? { get set }
}

/// Protocol defining the required behavior for the university details data manager.
protocol UniversityDetailsDataManagerInputProtocol: AnyObject { }

/// Protocol defining the required behavior for the university details API data manager.
protocol UniversityDetailsAPIDataManagerInputProtocol: AnyObject { }

/// Protocol defining the required behavior for the university details local data manager.
protocol UniversityDetailsLocalDataManagerInputProtocol: AnyObject { }
