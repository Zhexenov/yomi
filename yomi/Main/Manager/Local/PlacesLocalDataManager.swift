//
//  PlacesLocalDataManager.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Foundation


protocol IPlacesLocalDataManager : MainDataManager {
    
}


class PlacesLocalDataManager : IPlacesLocalDataManager {
    
    weak var handler: MainDataManagerOutput?
    
    
    func fetchNearbyPlaces() {
        
    }
}
