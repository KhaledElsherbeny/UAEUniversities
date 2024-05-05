//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit
import Domain

/// View controller responsible for displaying university details.
public final class UniversityDetailsView: UIViewController, UniversityDetailsViewProtocol {
    /// Reference to the presenter.
    var presenter: UniversityDetailsPresenterProtocol?
    
    /// Label displaying the university name.
    @IBOutlet weak var universityNameLabel: UILabel!
    
    /// Label displaying the university state.
    @IBOutlet weak var unversityStateLabel: UILabel!
    
    /// Label displaying the country name.
    @IBOutlet weak var countryNameLabel: UILabel!
    
    /// Label displaying the country code.
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    /// Label displaying the university web page.
    @IBOutlet weak var webPageLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        title = "University Details"
        
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTapped)
        )
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    /// Action triggered when the refresh button is tapped.
    @objc private func refreshButtonTapped() {
        presenter?.didTapRefresh()
    }
}

extension UniversityDetailsView {
    /// Updates the view with the provided university item.
    /// - Parameter universityItem: The university item to display.
    func updateView(with universityItem: UniversityListItem) {
        universityNameLabel.text = universityItem.name
        unversityStateLabel.text = universityItem.stateProvince ?? "N/A"
        countryNameLabel.text = universityItem.country
        countryCodeLabel.text = universityItem.alphaTwoCode
        webPageLabel.text = universityItem.webPages.first ?? "N/A"
    }
}
