//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import UIKit
import Domain

public protocol UniversityDetailsOutputDelegate: AnyObject {
    func didRefreshListView()
}

protocol UniversityDetailsViewProtocol: AnyObject {
    var presenter: UniversityDetailsPresenterProtocol? { get set }
    
    func updateView(with universityItem: UniversityListItem)
}

protocol UniversityDetailsWireFrameProtocol: AnyObject {
    var viewController: UIViewController? { get set }

    static func presentUniversityDetailsModule(
        with universityItem: UniversityListItem,
        delegate: UniversityDetailsOutputDelegate?
    ) -> UIViewController
    
    func dismiss()
}

protocol UniversityDetailsPresenterProtocol: AnyObject {
    var view: UniversityDetailsViewProtocol? { get set }
    var interactor: UniversityDetailsInteractorInputProtocol? { get set }
    var wireFrame: UniversityDetailsWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func didTapRefresh()
}

protocol UniversityDetailsInteractorOutputProtocol: AnyObject { }

protocol UniversityDetailsInteractorInputProtocol: AnyObject {
    var presenter: UniversityDetailsInteractorOutputProtocol? { get set }
    var APIDataManager: UniversityDetailsAPIDataManagerInputProtocol? { get set }
    var localDataManager: UniversityDetailsLocalDataManagerInputProtocol? { get set }
}

protocol UniversityDetailsDataManagerInputProtocol: AnyObject { }

protocol UniversityDetailsAPIDataManagerInputProtocol: AnyObject { }

protocol UniversityDetailsLocalDataManagerInputProtocol: AnyObject { }
