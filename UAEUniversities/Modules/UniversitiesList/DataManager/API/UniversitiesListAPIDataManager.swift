//
// Created by VIPER
// Copyright (c) 2024 VIPER. All rights reserved.
//

import Foundation
import NetworkKit

final class UniversitiesListAPIDataManager: UniversitiesListAPIDataManagerInputProtocol {
    
    var networkManager: NetworkSendableProtocol = NetworkManager.shared
    
    func fetchUniversitiesList(contry: String, completion: @escaping (Result<[UniversitiesListItem], Error>)-> Void) {
        networkManager.send(
            model: [UniversitiesListItem].self,
            endpoint: UniversitiesSearchEndpoint.getUniversities(country: "")
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
