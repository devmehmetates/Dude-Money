//
//  SummaryRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import UIKit

protocol SummaryRouterInterface: AnyObject {
    func popView()
}

final class SummaryRouter: SummaryRouterInterface {
    
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> SummaryViewController {
        let router = SummaryRouter()
        let view: SummaryViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(ofType: SummaryViewController.self)
        let interactor = SaveService()
        let presenter = SummaryPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

// MARK: - Interface Setup
extension SummaryRouter {
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
