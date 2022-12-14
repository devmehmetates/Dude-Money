//
//  TabbarRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

import UIKit

protocol TabBarRouterInterface: AnyObject {
    func popView()
}

final class TabBarRouter {
    
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> TabBarViewController {
        let router = TabBarRouter()
        let view = TabBarViewController()
        let presenter = TabBarPresenter(view: view, router: router)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

// MARK: - Interface Setup
extension TabBarRouter: TabBarRouterInterface {
    
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
