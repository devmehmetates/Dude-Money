//
//  TabbarPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

protocol TabBarPresenterInterface: AnyObject {
    func notifyViewLoaded()
}

final class TabBarPresenter {
    
    private weak var view: TabBarViewInterface?
    private weak var router: TabBarRouterInterface?
    
    init(view: TabBarViewInterface?, router: TabBarRouterInterface?) {
        self.view = view
        self.router = router
    }
}

// MARK: - Interface Setup
extension TabBarPresenter: TabBarPresenterInterface {
    
    func notifyViewLoaded() {
        view?.setupView()
    }
}
