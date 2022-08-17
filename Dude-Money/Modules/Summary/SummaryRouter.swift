//
//  SummaryRouter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

import UIKit

protocol SummaryRouterInterface: AnyObject {
    func performSegue(with identifier: String)
    func popView()
}

final class SummaryRouter {
    
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> SummaryViewController {
        let router = SummaryRouter()
        // TODO: bunun için bir extension araştırılacak
        guard let view = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "summaryVC") as? SummaryViewController else { return SummaryViewController() }
        let interactor = SummaryInteractor()
        let presenter = SummaryPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        router.navigationController = navigationController
        
        return view
    }
}

// MARK: - Interface Setup
extension SummaryRouter: SummaryRouterInterface {
    
    func performSegue(with identifier: String) {
        self.navigationController?.present(MockViewController(), animated: true)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}
