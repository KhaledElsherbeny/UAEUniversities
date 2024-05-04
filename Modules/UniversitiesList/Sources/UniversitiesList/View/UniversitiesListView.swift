//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    static let reuseIdentifier = "TableViewCell"

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            // Customize your cell here
        }
}

final public class UniversitiesListView: UIViewController, UniversitiesListViewProtocol {
    var presenter: UniversitiesListPresenterProtocol?
    
    @IBOutlet private(set) var tableView: UITableView!
    
    public override func viewDidLoad() {
          super.viewDidLoad()
      }
}

extension UniversitiesListView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Hello \(indexPath.row)"
        return cell
    }
}
