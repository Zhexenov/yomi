//
//  MainModule.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Foundation


class MainModule : IModule {
    
    let router: IAppRouter

    init(router: IAppRouter) {
        self.router = router
    }

    func presentView(parameters: [String: Any], presentType: PresentType) {
        let wireframe = router.resolver.resolve(IMainWireframe.self, argument: router)!
        wireframe.presentView(presentType: presentType)
    }
}
