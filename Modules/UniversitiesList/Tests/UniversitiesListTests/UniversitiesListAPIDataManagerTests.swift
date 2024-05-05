import XCTest
import NetworkKit
@testable import UniversitiesList

class UniversitiesListAPIDataManagerTests: XCTestCase {
    func testFetchUniversitiesListSuccess() {
        let mockResponse: [UniversityListItemDTO] = [
            UniversityListItemDTO(name: "University A", country: "Country A"),
            UniversityListItemDTO(name: "University B", country: "Country B"),
            UniversityListItemDTO(name: "University C", country: "Country C"),
            UniversityListItemDTO(name: "University D", country: "Country D"),
            UniversityListItemDTO(name: "University E", country: "Country E")
        ]
        
        let mockNetworkManager = MockNetworkManager(mockResponse: .success(mockResponse))
        let dataManager = UniversitiesListAPIDataManager()
        dataManager.networkManager = mockNetworkManager

        // Perform fetch universities list
        let expectation = XCTestExpectation(description: "Fetch universities list")
        dataManager.fetchUniversitiesList(country: "Country A") { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, mockResponse.count)
            case .failure:
                XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchUniversitiesListFailure() {
        let mockNetworkManager = MockNetworkManager<[UniversityListItemDTO]>(mockResponse: .failure(NetworkError.serverError))
        let dataManager = UniversitiesListAPIDataManager()
        dataManager.networkManager = mockNetworkManager

        // Perform fetch universities list
        let expectation = XCTestExpectation(description: "Fetch universities list")
        dataManager.fetchUniversitiesList(country: "Country A") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.serverError)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Mock NetworkManager for testing
class MockNetworkManager<T: Codable>: NetworkSendableProtocol {
    var mockResponse: Result<T, NetworkError>
    
    init(mockResponse: Result<T, NetworkError>) {
        self.mockResponse = mockResponse
    }
    
    func send<U: Decodable>(
        model: U.Type,
        endpoint: BaseEndpoint,
        completionHandler: @escaping (Result<U, NetworkError>) -> Void
    ) {
        switch mockResponse {
        case .success(let responseModel):
            completionHandler(.success(responseModel as! U))
        case .failure(let error):
            completionHandler(.failure(error))
        }
    }
}

extension UniversityListItemDTO {
    init(name: String, country: String) {
        self.init()
        self.name = name
        self.country = country
    }
}
