//
//  UniversityListItem.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

/// Represents a University List Item.
public struct UniversityListItem {
    /// The alpha two code of the country.
    public var alphaTwoCode: String = ""
    /// The name of the university.
    public var name: String = ""
    /// The country where the university is located.
    public var country: String = ""
    /// The domains associated with the university.
    public var domains: [String] = []
    /// The web pages related to the university.
    public var webPages: [String] = []
    /// The state or province where the university is located.
    public var stateProvince: String?
    
    /// Initializes a new UniversityListItem instance.
    public init() {}
}
