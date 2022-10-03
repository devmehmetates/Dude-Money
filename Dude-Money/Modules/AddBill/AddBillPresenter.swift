//
//  AddBillPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import Foundation

protocol AddBillPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func closeButtonTapped()
    func addButtonTapped(amount: String?)
    func priceTpyeValueChanged(_ selectedIndex: Int)
    func selectFriend(_ people: People)
    func pullDownButtonIsEnabled() -> Bool
}

final class AddBillPresenter {
    private weak var view: AddBillViewInterface?
    private var router: AddBillRouterInterface?
    private var manager: SaveManagerInterface?
    private var priceType: PriceType = .Debt
    private var selectedPeople: People?
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, manager: SaveManagerInterface?) {
        self.view = view
        self.router = router
        self.manager = manager
    }
    
    private func savePeople(_ people: People) {
        manager?.saveUser(people)
    }
    
    private func readPeople() -> People? {
        manager?.readUser()
    }
}

extension AddBillPresenter: AddBillPresenterInterface {
    
    func selectFriend(_ people: People) {
        selectedPeople = people
    }
    
    func priceTpyeValueChanged(_ selectedIndex: Int) {
        if selectedIndex == PriceType.Receivable.rawValue {
            view?.configurePriceTpyeSegmentedControlByReceivable()
            priceType = .Receivable
            return
        }
        
        view?.configurePriceTpyeSegmentedControlByDebt()
        priceType = .Debt
    }
    
    func addButtonTapped(amount: String?) {
        guard let whose = selectedPeople?.username, let amount = Double(amount ?? "") else { return }
        guard var people = readPeople() else { return }

        let bill = Bill(whose: whose, ammount: priceType == .Debt ? -amount : amount)
        if priceType == .Debt {
            people.debts.append(bill)
            savePeople(people)
            closeButtonTapped()
            return
        }
        
        people.receivables.append(bill)
        savePeople(people)
        closeButtonTapped()
    }
    
    func pullDownButtonIsEnabled() -> Bool {
        !(manager?.readUser()?.friends.isEmpty ?? true)
    }
    
    func closeButtonTapped() {
        router?.popView()
    }
    
    func notifyViewLoaded() {
        view?.configureFriendPullDownButton(manager?.readUser()?.friends)
        selectedPeople = manager?.readUser()?.friends.first
    }
}
