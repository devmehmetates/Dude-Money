//
//  SummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

protocol SummaryPresenterInterface {
    func notifyViewLoaded()
    func notifyViewWillAppear()
}

final class SummaryPresenter {
    
    var view: SummaryViewInterface?
    var router: SummaryRouterInterface?
    var interactor: SummaryInteractorInterface?
    var bills: [Bill]? = []
    var people: People = People.exampleModel
}

// MARK: - Interface Setup
extension SummaryPresenter: SummaryPresenterInterface {
    func notifyViewLoaded() {
        view?.setupView()
        view?.setupToolbar()
    }
    
    func notifyViewWillAppear() {
        
    }
}
