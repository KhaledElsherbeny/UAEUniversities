//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit
import UtilitiesKit

/// View controller responsible for displaying a list of universities.
final public class UniversitiesListView: UIViewController {
    /// Presenter responsible for handling view logic.
    var presenter: UniversitiesListPresenterProtocol?
    
    /// Table view displaying the list of universities.
    @IBOutlet private(set) var tableView: UITableView!
    
    /// Called after the controller's view is loaded into memory.
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        fetchUniversitiesList()
    }
    
    /// Sets up the table view.
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: UniversityItemCell.reuseIdentifier, bundle: .module),
            forCellReuseIdentifier: UniversityItemCell.reuseIdentifier
        )
    }
    
    /// Sets up the navigation bar.
    private func setupNavigationBar() {
        title = "Universities list"
    }
    
    /// Fetches the list of universities.
    private func fetchUniversitiesList() {
        presenter?.fetchUniversitiesList(country: "United Arab Emirates")
    }
}

extension UniversitiesListView: UniversitiesListViewProtocol {
    /// Shows the loading view.
    func showLoadingView() {
        LoadingView.start()
    }
    
    /// Hides the loading view.
    func hideLoadingView() {
        LoadingView.stop()
    }
    
    /// Updates the view.
    func updateView() {
        tableView.reloadData()
    }
    
    /// Displays an error message.
    ///
    /// - Parameter error: The error message to display.
    func showError(error: String) {
        let alertController = AlertBuilder
            .init(
                message: error,
                preferredStyle: .alert
            )
            .addAction(title: "OK", style: .default, handler: nil)
            .build()
        present(alertController, animated: true, completion: nil)
    }

    /// Shows the empty state view.
    func showEmptyStateView() {}
    
    /// Hides the empty state view.
    func hideEmptyStateView() {}
}

extension UniversitiesListView: UITableViewDelegate, UITableViewDataSource {
    /// Tells the data source to return the number of rows in a given section of a table view.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    /// Asks the data source for a cell to insert in a particular location of the table view.
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
    
    /// Tells the delegate that the specified row is now selected.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}
