//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import UIKit

final public class UniversitiesListView: UIViewController, UniversitiesListViewProtocol {
    var presenter: UniversitiesListPresenterProtocol?
    
    @IBOutlet private(set) var tableView: UITableView!
    
    public override func viewDidLoad() {
        
    }
}
