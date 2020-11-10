//
//  MainDataManager.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Foundation


protocol MainDataManager : class {
    
    var handler: MainDataManagerOutput? { get set }
    
    func fetchNearbyPlaces()
}


protocol MainDataManagerOutput : class {
    
    func placesFetched(_ list: [Place])
    
    func onError(code: Int, message: String?)
}
