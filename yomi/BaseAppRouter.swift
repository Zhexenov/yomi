//
//  BaseAppRouter.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Swinject


protocol IProductRouter : class {
    
    func presentModule(module: Module, parameters: [String: Any], presentType: PresentType)
}


class BaseAppRouter : IAppRouter {
    private var assembler: Assembler!
    private var products: [String: (_ appRouter: IAppRouter) -> IProductRouter] = [:]
    let appDelegate = UIApplication.shared.delegate
    var navigationController: UINavigationController?
    
    init(assembler: Assembler, products: [String: (_ appRouter: IAppRouter) -> IProductRouter]) {
        self.assembler = assembler
        self.products = products
    }
    
    var resolver: Resolver {
        return assembler.resolver
    }
    
    func presentModule(module: Module, parameters: [String: Any], presentType: PresentType) {
        if let productConstuctor = products[module.productName] {
            let product = productConstuctor(self)
            product.presentModule(module: module, parameters: parameters, presentType: presentType)
        }
    }
    
    func present(view: UIViewController, animatedDisplay: Bool, animatedDismiss: Bool, presentType: PresentType) {
        switch presentType {
        case .root:
            appDelegate?.window??.rootViewController = UINavigationController(rootViewController: view)
            navigationController = appDelegate?.window??.rootViewController as? UINavigationController
        case .push:
            navigationController?.pushViewController(view, animated: animatedDisplay)
        case .present:
            navigationController?.present(view, animated: animatedDisplay, completion: nil)
        }
    }
}
