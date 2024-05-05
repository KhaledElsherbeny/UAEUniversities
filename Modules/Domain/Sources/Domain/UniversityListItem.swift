//
//  UniversityListItem.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

public struct UniversityListItem {
    public var alphaTwoCode: String = ""
    public var name: String = ""
    public var country: String = ""
    public var domains: [String] = []
    public var webPages: [String] = []
    public var stateProvince: String?
    
    public init() {
        
    }
}
