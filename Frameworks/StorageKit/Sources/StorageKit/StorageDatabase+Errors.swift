//
//  StorageDatabaseError.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation

public enum StorageDatabaseError: Error {
    case databaseNotFound
    case unableToAccessDatabase
    case databaseReadError
    case databaseWriteError
}

