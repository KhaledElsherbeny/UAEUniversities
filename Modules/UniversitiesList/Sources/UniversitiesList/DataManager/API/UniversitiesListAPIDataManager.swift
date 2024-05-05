//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import NetworkKit

/// Data manager responsible for managing API requests related to university list.
final class UniversitiesListAPIDataManager: UniversitiesListAPIDataManagerInputProtocol {
    
    /// Network manager responsible for handling network requests.
    var networkManager: NetworkSendableProtocol = NetworkManager.shared
    
    /// Fetches the list of universities from the API.
    ///
    /// - Parameters:
    ///   - country: The country for which the list of universities is to be fetched.
    ///   - completion: A closure to be executed when the request finishes. It returns a result containing either the list of universities or a network error.
    func fetchUniversitiesList(
        country: String,
        completion: @escaping (Result<[UniversityListItemDTO], NetworkError>)-> Void
    ) {
        networkManager.send(
            model: [UniversityListItemDTO].self,
            endpoint: UniversitiesSearchEndpoint.getUniversities(country: country)
        ) { response in
            switch response {
            case .success(let itemsList):
                completion(.success(itemsList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
