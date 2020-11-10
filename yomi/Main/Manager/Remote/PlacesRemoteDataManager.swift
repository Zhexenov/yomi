//
//  PlacesRemoteDataManager.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Moya


func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}


protocol IPlacesRemoteDataManager : MainDataManager {
    
}


class PlacesRemoteDataManager : IPlacesRemoteDataManager {
    
    weak var handler: MainDataManagerOutput?
    
    private var provider = MoyaProvider<PizzeriaApi>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
    
    func fetchNearbyPlaces() {
        provider.request(.nearby) { [weak self] (result) in
            switch result {
            case let .success(response):
                if let searchResponse: SearchResponse = try? JSONDecoder().decode(SearchResponse.self, from: response.data) {
                    self?.handler?.placesFetched(searchResponse.results)
                    return
                }
                self?.handler?.onError(code: response.statusCode, message: "Parsing error")
            case let .failure(error):
                self?.handler?.onError(code: error.errorCode, message: error.errorDescription)
            }
        }
    }
}
