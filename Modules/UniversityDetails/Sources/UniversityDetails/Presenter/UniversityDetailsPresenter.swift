//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import Domain

final class UniversityDetailsPresenter: UniversityDetailsPresenterProtocol, UniversityDetailsInteractorOutputProtocol {
    weak var view: UniversityDetailsViewProtocol?
    var interactor: UniversityDetailsInteractorInputProtocol?
    var wireFrame: UniversityDetailsWireFrameProtocol?
    
    weak var delegate: UniversityDetailsOutputDelegate?
    private let universityItem: UniversityListItem
    
    init(
        universityItem: UniversityListItem,
        delegate: UniversityDetailsOutputDelegate? = nil
    ) {
        self.universityItem = universityItem
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        view?.updateView(with: universityItem)
    }
    
    func didTapRefresh() {
        delegate?.didRefreshListView()
        wireFrame?.dismiss()
    }
}
