//
//  SummaryRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import UIKit

protocol SummaryRouterInterface: AnyObject {
    func popView()
    func presentAddBill()
}

final class SummaryRouter {
    
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> SummaryViewController {
        let router = SummaryRouter()
        let view: SummaryViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(ofType: SummaryViewController.self)
        let manager = SaveManager()
        let presenter = SummaryPresenter(view: view, router: router, manager: manager)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

// MARK: - Interface Setup
extension SummaryRouter: SummaryRouterInterface {
    
    func presentAddBill() {
        let rootNavController: UINavigationController = navigationController ?? UINavigationController()
        let addBillController: UIViewController = AddBillRouter.createModule(using: rootNavController)
        addBillController.modalPresentationStyle = .fullScreen
        navigationController?.present(addBillController, animated: true)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
