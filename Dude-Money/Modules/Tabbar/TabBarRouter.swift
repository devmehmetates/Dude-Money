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

final class TabBarRouter {
    // buralarda da neden weak var?
    weak var presenter: TabBarPresenter?
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> TabBarViewController {
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        guard let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "tabbarVC")
                as? TabBarViewController else { return TabBarViewController() }
        
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
