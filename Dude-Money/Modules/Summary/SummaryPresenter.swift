//
//  SummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

protocol SummaryPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func fetchPeople()
    func getUserProfileIcon() -> String
    func getDebtDataByIndex(_ index: Int) -> (bill: Bill, friend: People)?
    func getDebtsCount() -> Int
    func getReceivablesDataByIndex(_ index: Int) -> (bill: Bill, friend: People)?
    func getReceivablesCount() -> Int
    func getDebtIsEmpty() -> Bool
    func getReceivablesIsEmpty() -> Bool
    func getUserBalance() -> Double
}

final class SummaryPresenter {
    
    private weak var view: SummaryViewInterface?
    private weak var router: SummaryRouterInterface?
    private var interactor: SummaryInteractorInterface? // references not the same when weak
    private var people: People?
    
    init(view: SummaryViewInterface?, router: SummaryRouterInterface?, interactor: SummaryInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Interface Setup
extension SummaryPresenter: SummaryPresenterInterface {
    
    func getUserBalance() -> Double {
        people?.balance ?? 0
    }
    
    func getDebtIsEmpty() -> Bool {
        people?.debts.isEmpty ?? false
    }
    
    func getReceivablesIsEmpty() -> Bool {
        people?.receivables.isEmpty ?? false
    }
    
    
    func getDebtDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        guard people?.debts.isEmpty == false else { return nil }
        guard let bill = people?.debts[index] else { return nil }
        guard let friend = (people?.friends.first { $0.username == bill.whose }) else { return nil }
        return (bill: bill, friend: friend)
    }
    
    func getReceivablesDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        guard people?.receivables.isEmpty == false else { return nil }
        guard let bill = people?.receivables[index] else { return nil }
        guard let friend = (people?.friends.first { $0.username == bill.whose }) else { return nil }
        return (bill: bill, friend: friend)
    }
    
    func getDebtsCount() -> Int {
        (people?.debts.isEmpty ?? true) ? 1 : people?.debts.count ?? 0
    }
    
    func getReceivablesCount() -> Int {
        (people?.receivables.isEmpty ?? true) ? 1 : people?.receivables.count ?? 0
    }
    
    func fetchPeople() {
        self.people = interactor?.readPeople()
    }
    
    func notifyViewLoaded() {
        view?.setupView()
        fetchPeople()
        view?.setupToolbar()
    }
    
    func getUserProfileIcon() -> String {
        people?.icon ?? "example0"
    }
}
