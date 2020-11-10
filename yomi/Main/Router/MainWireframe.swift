//
//  MainWireframe.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import UIKit


protocol IMainWireframe : class {
    
    func presentView(presentType: PresentType)
    
}


final class MainWireframe : IMainWireframe {
    
    let router: IAppRouter
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentView(presentType: PresentType) {
        guard let view = router.resolver.resolve(IMainView.self, argument: router) as? UIViewController else {
            fatalError("IView to present is not UIViewController")
        }
        router.present(view: view, animatedDisplay: true, animatedDismiss: true, presentType: presentType)
    }
}
