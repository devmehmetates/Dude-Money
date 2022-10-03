//
//  AddBillRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import UIKit

protocol AddBillRouterInterface: AnyObject {
    func popView()
}

final class AddBillRouter {
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> AddBillViewController {
        let router = AddBillRouter()
        let view = AddBillViewController(nibName: "AddBillViewController", bundle: nil)
        let manager = SaveManager()
        let presenter = AddBillPresenter(view: view, router: router, manager: manager)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

extension AddBillRouter: AddBillRouterInterface {
    func popView() {
        navigationController?.dismiss(animated: true)
    }
}
