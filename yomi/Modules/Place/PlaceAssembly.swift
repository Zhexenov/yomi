//
//  PlaceAssembly.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/11/20.
//  Copyright (c) 2020 Jex. All rights reserved.


import Swinject


class PlaceAssembly : Assembly {
    
    init() { }
    
    func assemble(container: Container) {
        container.register(PlaceModule.self) { (_, appRouter: IAppRouter) in
            PlaceModule(router: appRouter)
        }
        
        container.register(IPlaceWireframe.self) { (_, appRouter: IAppRouter) -> IPlaceWireframe in
            PlaceWireframe(router: appRouter)
        }
        
        container.register(IPlacePresenter.self) { (r, appRouter: IAppRouter, view: IPlaceView) in
            let wireframe = r.resolve(IPlaceWireframe.self, argument: appRouter)!
            let presenter = PlacePresenter(wireframe: wireframe, view: view)
            return presenter
        }
        
        container.register(IPlaceView.self) { (r, appRouter: IAppRouter, parameters: [String: Any]) in
            let view: IPlaceView = PlaceViewController()
            let presenter = r.resolve(IPlacePresenter.self, arguments: appRouter, view as IPlaceView)!
            presenter.parameters = parameters
            view.presenter = presenter
            return view
        }
    }
}
