//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit
import UtilitiesKit

final public class UniversitiesListView: UIViewController {
    var presenter: UniversitiesListPresenterProtocol?
    
    @IBOutlet private(set) var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: UniversityItemCell.reuseIdentifier, bundle: .module),
            forCellReuseIdentifier: UniversityItemCell.reuseIdentifier
        )
    }
    
    private func setupNavigationBar() {
        title = "Unversities list"
    }
}

extension UniversitiesListView: UniversitiesListViewProtocol {
    func showLoadingView() {
        LoadingView.show()
    }
    
    func hideLoadingView() {
        LoadingView.hide()
    }
    
    func updateView() {
        hideLoadingView()
        tableView.reloadData()
    }
    
    func showError(error: String) {
        hideLoadingView()
        let alertController = AlertBuilder
            .init(
                message: error,
                preferredStyle: .alert
            )
            .addAction(title: "OK", style: .default, handler: nil)
            .build()
        present(alertController, animated: true, completion: nil)
    }

    func showEmptyStateView() {}
    
    func hideEmptyStateView() {}
}

extension UniversitiesListView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = UniversityItemCell.reuseIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UniversityItemCell,
              let item = presenter?.item(at: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.config(with: item)
        return cell
    }
}
