//
//  UniversityItemCell.swift
//  
//
//  Created by Khalid on 04/05/2024.
//

import UIKit

final class UniversityItemCell: UITableViewCell {

    static let reuseIdentifier = "UniversityItemCell"
    
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityProvinceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(with university: UniversityListItemUIModel) {
        universityNameLabel.text = university.name
        universityProvinceLabel.text = university.stateProvince
    }
}
