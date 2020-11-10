//
//  AppRouter.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import UIKit
import Swinject


enum PresentType {
    case root, push, present
}


protocol IAppRouter {
    
    var resolver: Resolver { get }
    
    func present(view: UIViewController, animatedDisplay: Bool, animatedDismiss: Bool, presentType: PresentType)

}


class AppRouter : BaseAppRouter {
    public static let shared = AppRouter.createAppRouter()
    public static var assembler = Assembler()
    public static var products: [String: (_ appRouter: IAppRouter) -> IProductRouter] = [:]

    private static func createAppRouter() -> AppRouter {
        let router = AppRouter(assembler: assembler, products: products)
        return router
    }
}
