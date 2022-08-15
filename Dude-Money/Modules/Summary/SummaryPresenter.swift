//
//  SummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

protocol SummaryPresenterInterface {
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func fetchPeople()
}

final class SummaryPresenter {
    
    var view: SummaryViewInterface?
    var router: SummaryRouterInterface?
    var interactor: SummaryInteractorInterface?
    var people: People?
}

// MARK: - Interface Setup
extension SummaryPresenter: SummaryPresenterInterface {
    func fetchPeople() {
        people = interactor?.readPeople()
    }
    
    func notifyViewLoaded() {
        view?.setupView()
        view?.setupToolbar()
        fetchPeople()
    }
    
    func notifyViewWillAppear() {
        
    }
}
