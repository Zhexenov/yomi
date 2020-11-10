//
//  MainAssembly.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Swinject


class MainAssembly : Assembly {
    
    init() { }
    
    func assemble(container: Container) {
        
        container.register(IMainWireframe.self) { (_, appRouter: IAppRouter) -> IMainWireframe in
            MainWireframe(router: appRouter)
        }
        
        container.register(IPlacesRemoteDataManager.self) { _ in
            PlacesRemoteDataManager()
        }
        
        container.register(IPlacesLocalDataManager.self) { _ in
            PlacesLocalDataManager()
        }
        
        container.register(IMainInteractor.self) { r in
            let localDataManager = r.resolve(IPlacesLocalDataManager.self)!
            let remoteDataManager = r.resolve(IPlacesRemoteDataManager.self)!
            let interactor = MainInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
            localDataManager.handler = interactor
            remoteDataManager.handler = interactor
            return interactor
        }
        
        container.register(IMainPresenter.self) { (r, appRouter: IAppRouter, view: IMainView) in
            let wireframe = r.resolve(IMainWireframe.self, argument: appRouter)!
            let interactor = r.resolve(IMainInteractor.self)!
            let presenter = MainPresenter(interactor: interactor, wireframe: wireframe, view: view)
            interactor.presenter = presenter
            return presenter
        }
        
        container.register(IMainView.self) { (r, appRouter: IAppRouter) in
            let view: IMainView = MainViewController()
            let presenter = r.resolve(IMainPresenter.self, arguments: appRouter, view)
            view.presenter = presenter
            return view
        }
    }
}
