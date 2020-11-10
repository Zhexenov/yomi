//
//  PizzeriaApi.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Moya


enum PizzeriaApi {
    case nearby
}


extension PizzeriaApi : TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: baseUrl) else { fatalError("Invalid base url") }
        return url
    }
    
    var path: String {
        switch self {
        case .nearby: return "/maps/api/place/nearbysearch/json"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        
        switch self {
        case .nearby:
            params["location"] = "40.730610, -73.935242"
            params["radius"] = 1500
            params["type"] = "restaurant"
            params["keyword"] = "pizza"
            params["key"] = "AIzaSyBiRVx52qdWYGMZnUGwZdbNRYIjBoICNVk"
            return params
        }
    }
    
    var sampleData: Data {
        return "Test sample data".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? { return nil }
}
