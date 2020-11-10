//
//  PlaceWireframe.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import UIKit


class PlaceWireframe: IPlaceWireframe {
    
    let router: IAppRouter

    init(router: IAppRouter) {
        self.router = router
    }

    func presentView(parameters: [String: Any], presentType: PresentType) {
        guard let view = router.resolver.resolve(IPlaceView.self, arguments: router, parameters) as? UIViewController else {
            fatalError("IView to present is not UIViewController")
        }
        router.present(view: view, animatedDisplay: true, animatedDismiss: true, presentType: presentType)
    }
}
