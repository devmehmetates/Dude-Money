//
//  SummaryPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 14.08.2022.
//

protocol SummaryPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func fetchPeople()
    func getDebtDataByIndex(_ index: Int) -> (bill: Bill, friend: People)?
    func getReceivablesDataByIndex(_ index: Int) -> (bill: Bill, friend: People)?
    var getSectionCount: Int { get }
    var getUserProfileIcon: String { get }
    var getUserBalance: Double { get }
    var getReceivablesCount: Int { get }
    var getReceivablesIsEmpty: Bool { get }
    var getDebtsCount: Int { get }
    var getDebtIsEmpty: Bool { get }
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
    
    var getUserProfileIcon: String {
        people?.icon ?? "example0"
    }
    
    var getReceivablesCount: Int {
        (people?.receivables.isEmpty ?? true) ? 1 : people?.receivables.count ?? 0
    }
    
    var getReceivablesIsEmpty: Bool {
        people?.receivables.isEmpty ?? false
    }
    
    var getDebtsCount: Int {
        (people?.debts.isEmpty ?? true) ? 1 : people?.debts.count ?? 0
    }
    
    var getDebtIsEmpty: Bool {
        people?.debts.isEmpty ?? false
    }
    
    var getUserBalance: Double {
        people?.balance ?? 0
    }
    
    
    var getSectionCount: Int {
        3
    }
    
    func getDebtDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        guard people?.debts.isEmpty == false,
              let bill = people?.debts[index],
              let friend = (people?.friends.first { $0.username == bill.whose })
        else { return nil }
        return (bill: bill, friend: friend)
    }
    
    func getReceivablesDataByIndex(_ index: Int) -> (bill: Bill, friend: People)? {
        guard people?.receivables.isEmpty == false,
              let bill = people?.receivables[index],
              let friend = (people?.friends.first { $0.username == bill.whose })
        else { return nil }
        return (bill: bill, friend: friend)
    }
    
    func fetchPeople() {
        people = interactor?.people
    }
    
    func notifyViewLoaded() {
        view?.setupView()
        fetchPeople()
        view?.setupToolbar()
    }
}
