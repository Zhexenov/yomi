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
        remoteDataManager.fetchNearbyPlaces()
    }
}


extension MainInteractor : MainDataManagerOutput {
    func placesFetched(_ list: [Place]) {
        presenter?.onPlacesFound(list)
    }
    
    func onError(code: Int, message: String?) {
        print(code, message ?? "nil")
    }
}
