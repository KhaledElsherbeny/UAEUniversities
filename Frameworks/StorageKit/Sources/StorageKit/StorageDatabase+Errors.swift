//
//  File.swift
//  
//
//  Created by Khalid on 05/05/2024.
//

import Foundation

public enum StorageDatabaseError: Error {
    case databaseNotFound
    case unableToAccessDatabase
    case databaseReadError
    case databaseWriteError
}

