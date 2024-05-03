//
//  BaseEndpoint.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import Foundation
import Network

public typealias Parameters = [String: Any]
public typealias Headers = [String: String]

public enum RequestEncoding {
    case queryString
    case requestBody
    case multiPartFormData
}

public protocol BaseEndpoint {
    var baseUrl: URL { get }
    var requestUrl: URL { get }
    var path: String { get }
    var parameters: Parameters { get }
    var method: HTTPMethod { get }
    var headers: Headers { get }
    var encoding: RequestEncoding { get }
    var urlRequest: URLRequest { get }
}

public extension BaseEndpoint {
    
    var encoding: RequestEncoding {
        switch method {
        default:
            return .queryString
        }
    }
    
    var baseUrl: URL {
        guard let url = URL(string: APIConstants.baseUrl) else {
            fatalError("Invalid Base URL , Please check base url")
        }
        return url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        return [:]
    }
    
    var headers: Headers {
        return [:]
    }
    
    var requestUrl: URL {
        let strUrl = baseUrl.appendingPathComponent(path).absoluteString
        guard let url = URL(string: strUrl) else {
            fatalError("Invalid Endpoint URL , Please check URL")
        }
        return url
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method.rawValue
        
        request.httpBody = httpBody
        request.url = url
        request.allHTTPHeaderFields = allHTTPHeaders
                
        return request
    }
    
    private var httpBody: Data? {
        guard encoding == .requestBody, !parameters.isEmpty else {
            return nil
        }
        guard let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
            return nil
        }
        return bodyData
    }
    
    private var url: URL {
        guard encoding == .queryString,
              !parameters.isEmpty,
              var urlComponents = URLComponents(url: requestUrl, resolvingAgainstBaseURL: false) else {
            return requestUrl
        }
        
        urlComponents.queryItems = [URLQueryItem]()
        parameters.forEach {
            let queryItem = URLQueryItem(name: $0.key,value: "\($0.value)")
            urlComponents.queryItems?.append(queryItem)
        }
        return urlComponents.url ?? requestUrl
    }
    
    private var allHTTPHeaders: [String: String] {
        var requestHeaders: [String: String] = headers
        switch encoding {
        case .multiPartFormData:
            requestHeaders["Content-Type"] = "multipart/form-data"
        case .requestBody,.queryString:
            requestHeaders["Content-Type"] = "application/json"
        }
        return requestHeaders
    }
}
