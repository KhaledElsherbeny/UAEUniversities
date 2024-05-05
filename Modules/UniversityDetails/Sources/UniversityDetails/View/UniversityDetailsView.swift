//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit
import Domain

public final class UniversityDetailsView: UIViewController, UniversityDetailsViewProtocol {
    var presenter: UniversityDetailsPresenterProtocol?
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var unversityStateLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var webPageLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        title = "Unversity Details"
        
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTapped)
        )
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc private func refreshButtonTapped() {
        presenter?.didTapRefresh()
    }
}

extension UniversityDetailsView {
    func updateView(with universityItem: UniversityListItem) {
        universityNameLabel.text = universityItem.name
        unversityStateLabel.text = universityItem.stateProvince ?? "N/A"
        countryNameLabel.text = universityItem.country
        countryCodeLabel.text = universityItem.alphaTwoCode
        webPageLabel.text = universityItem.webPages.first ?? "N/A"
    }
}
