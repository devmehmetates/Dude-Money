//
//  TabbarPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

protocol TabBarPresenterInterface {
    func notifyViewLoaded()
    func notifyViewWillAppear()
}

final class TabBarPresenter {
    
    var view: TabBarViewController?
    var router: TabBarRouter?
    var interactor: TabBarInteractor?
}

// MARK: - Interface Setup
extension TabBarPresenter: TabBarPresenterInterface {
    
    func notifyViewLoaded() {
        view?.setupView()
    }
    
    func notifyViewWillAppear() {
        // running when view closing
    }
}
