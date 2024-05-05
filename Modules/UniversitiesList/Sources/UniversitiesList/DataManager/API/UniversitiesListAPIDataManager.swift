//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import NetworkKit

final class UniversitiesListAPIDataManager: UniversitiesListAPIDataManagerInputProtocol {
    
    var networkManager: NetworkSendableProtocol = NetworkManager.shared
    
    func fetchUniversitiesList(
        contry: String,
        completion: @escaping (Result<[UniversityListItemDTO], NetworkError>)-> Void
    ) {
        networkManager.send(
            model: [UniversityListItemDTO].self,
            endpoint: UniversitiesSearchEndpoint.getUniversities(country: contry)
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
