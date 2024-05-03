//
//  ViewController.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import UIKit
import NetworkKit
import StorageKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StorageDatabaseManager.sharedInstance.wipeStorage { bool in
            
        }
        // Do any additional setup after loading the view.
    }


}

