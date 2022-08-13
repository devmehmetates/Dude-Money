//
//  TabbarRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

import UIKit

protocol TabBarRouterInterface {
    func performSegue(with identifier: String)
    func presentPopup(with message: String)
}

class TabBarRouter {
    // buralarda da neden weak var?
    weak var presenter: TabBarPresenter?
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> TabBarViewController {
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        let view = TabBarViewController()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}
