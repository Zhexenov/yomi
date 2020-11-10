//
//  PlaceModule.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import Foundation


class PlaceModule : IModule {
    
    let router: IAppRouter

    init(router: IAppRouter) {
        self.router = router
    }

    func presentView(parameters: [String: Any], presentType: PresentType) {
        let wireframe = router.resolver.resolve(IPlaceWireframe.self, argument: router)!
        wireframe.presentView(parameters: parameters, presentType: presentType)
    }
}
