//
//  ProductRouter.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Foundation


class ProductRouter: IProductRouter {
    
    let router: IAppRouter
    
    let modules: [String: (IAppRouter) -> IModule] = [
        Products.Dev.MainModule.routePath: { MainModule(router: $0) },
    ]
    
    init(router: IAppRouter) {
        self.router = router
    }
    
    func presentModule(module: Module, parameters: [String : Any], presentType: PresentType) {
        if let moduleConstructor = modules[module.routePath] {
            let module = moduleConstructor(router)
            module.presentView(parameters: parameters, presentType: presentType)
        }
    }
}
