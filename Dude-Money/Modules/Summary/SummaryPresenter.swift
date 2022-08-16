//
//  SummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

protocol SummaryPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func fetchPeople()
}

final class SummaryPresenter {
    
    private weak var view: SummaryViewInterface?
    private weak var router: SummaryRouterInterface?
    private weak var interactor: SummaryInteractorInterface?
    private var people: People?
    
    init(view: SummaryViewInterface?, router: SummaryRouterInterface?, interactor: SummaryInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Interface Setup
extension SummaryPresenter: SummaryPresenterInterface {
    
    func fetchPeople() {
        people = interactor?.readPeople()
    }
    
    func notifyViewLoaded() {
        view?.setupView()
        fetchPeople()
        view?.setupToolbar()
    }
}
