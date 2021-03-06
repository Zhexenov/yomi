//
//  MainPresenter.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Foundation


protocol IMainPresenter : class {
    
    var view: IMainView? { get set }
    
    func viewDidLoad()
    
    func update()
    
    func onDidSelectPlace(_ place: Place)
}


class MainPresenter : IMainPresenter {
    
    weak var view: IMainView?
    private var interactor: IMainInteractor
    private var wireframe: IMainWireframe
    
    init(interactor: IMainInteractor, wireframe: IMainWireframe, view: IMainView) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.view = view
    }
    
    func viewDidLoad() {
        view?.showLoading?()
        interactor.findNearbyPizzerias()
    }
    
    func update() {
        interactor.findNearbyPizzerias()
    }
    
    func onDidSelectPlace(_ place: Place) {
        wireframe.presentPlaceModule(place)
    }
}


extension MainPresenter : IMainInteractorOutput {
    func onPlacesFound(_ list: [Place]) {
        view?.hideLoading?()
        view?.showPlaces(list)
    }
    
    func onError(_ message: String?) {
        view?.hideLoading?()
        
        if let msg = message {
            view?.showError?(message: msg)
        }
    }
}
