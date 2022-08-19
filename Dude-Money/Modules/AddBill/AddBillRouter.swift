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
        guard let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "addBill") as? AddBillViewController else { return AddBillViewController() }
        let interactor = AddBillInteractor()
        let presenter = AddBillPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

extension AddBillRouter: AddBillRouterInterface {
    
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
