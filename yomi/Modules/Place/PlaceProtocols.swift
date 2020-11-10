//
//  PlaceProtocols.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import Foundation


/* WireFrame */
protocol IPlaceWireframe : class {
    
    func presentView(parameters: [String: Any], presentType: PresentType)
    
}


/* Presenter */
protocol IPlacePresenter : IBasePresenter {
    
    var view: IPlaceView? { get set }
    var parameters: [String: Any]? { get set }
    
}


/* View */
protocol IPlaceView : IBaseView {
    
    var presenter: IPlacePresenter? { get set }
    
    func showPlaceDetails(_ place: Place)
}
