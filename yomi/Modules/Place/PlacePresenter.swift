//
//  PlacePresenter.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import Foundation


class PlacePresenter : IPlacePresenter {
    
    static let PLACE = "place"
	
	var wireframe: IPlaceWireframe?
	weak var view: IPlaceView?
    
	var parameters: [String: Any]?
	
	init( wireframe: IPlaceWireframe, view: IPlaceView) {
		self.wireframe = wireframe
		self.view = view
	}
    
    func viewDidLoad() {
        guard let place = parameters?[PlacePresenter.PLACE] as? Place else {
            fatalError("Place object cannot be null")
        }
        view?.showPlaceDetails(place)
    }
}
