//
//  Module.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//


import Foundation


protocol IModule {
    func presentView(parameters: [String: Any], presentType: PresentType)
}


protocol AppProduct {
    var productName: String { get }
}


protocol Module : AppProduct {
    var routePath: String { get }
}


enum Products {
    case DevProduct
    
    var productName: String {
        switch self {
        case .DevProduct:
            return "dev"
        }
    }
    
    enum Dev : Module {
        
        case MainModule
        case PizzeriaModule
        
        var productName: String {
            return "dev"
        }
        
        var routePath: String {
            switch self {
            case .MainModule: return "/dev/main"
            case .PizzeriaModule: return "/dev/pizzeria"
            }
        }
    }
}
