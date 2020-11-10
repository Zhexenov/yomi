//
//  MainInteractor.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Foundation


protocol IMainInteractor : class {
    
    var presenter: IMainInteractorOutput? { get set }
    
    func findNearbyPizzerias()
}


protocol IMainInteractorOutput : class {
    
    func onPlacesFound(_ list: [Place])
    
    func onError(_ message: String?)
}


class MainInteractor: IMainInteractor {
    
    weak var presenter: IMainInteractorOutput?
    private var localDataManager: IPlacesLocalDataManager
    private var remoteDataManager: IPlacesRemoteDataManager
    
    init(localDataManager: IPlacesLocalDataManager, remoteDataManager: IPlacesRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    
    func findNearbyPizzerias() {
        let list = localDataManager.fetchSavedPlaces()
        
        guard !list.isEmpty else {
            remoteDataManager.fetchNearbyPlaces()
            return
        }
        presenter?.onPlacesFound(list)
    }
}


extension MainInteractor : MainDataManagerOutput {
    func placesFetched(_ list: [Place]) {
        var topMostPlaces = list
        
        if list.count > 5 {
            topMostPlaces = Array(list.prefix(5))
        }
        presenter?.onPlacesFound(topMostPlaces)
        localDataManager.savePlaces(topMostPlaces)
    }
    
    func onError(code: Int, message: String?) {
        print(code, message ?? "nil")
    }
}
