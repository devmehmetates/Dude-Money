//
//  SummaryRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import UIKit

protocol SummaryRouterInterface {
    func performSegue(with identifier: String)
    func presentPopup(with message: String)
}

// TODO: !string constants!
final class SummaryRouter {
    weak var presenter: SummaryPresenter?
    weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> SummaryTableViewController {
        let router = SummaryRouter()
        let presenter = SummaryPresenter()
        let interactor = SummaryInteractor()
        guard let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "summaryVC") as? SummaryTableViewController else { return SummaryTableViewController() }
        
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

// MARK: - Interface Setup
extension SummaryRouter: SummaryRouterInterface {
    
    func performSegue(with identifier: String) {
        presenter?.view?.performSegue(withIdentifier: identifier, sender: self)
    }
    
    func presentPopup(with message: String) {
        self.navigationController?.popViewController(animated: true)
    }
}
