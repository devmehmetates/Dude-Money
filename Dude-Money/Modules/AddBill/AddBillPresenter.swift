//
//  AddBillPresenter.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import Foundation

protocol AddBillPresenterInterface: AnyObject {
    func notifyViewLoaded()
    func notifyViewWillAppear()
    func popView()
    func addBill(amount: String?)
    func priceTpyeValueChanged(_ selectedIndex: Int)
    func selectFriend(_ people: People)
    var getFriends: [People]? { get }
    var pullDownButtonIsEnabled: Bool { get }
}

final class AddBillPresenter {
    private weak var view: AddBillViewInterface?
    private var router: AddBillRouterInterface?
    private var interactor: AddBillInteractorInterface?
    private var people: People? {
        didSet {
            interactor?.savePeople(people)
        }
    }
    private var priceType: PriceType = .Debt
    private var selectedPeople: People?
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, interactor: AddBillInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
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
    
    func addBill(amount: String?) {
        guard let whose = selectedPeople?.username, let amount = Double(amount ?? "") else { return }

        let bill = Bill(whose: whose, ammount: priceType == .Debt ? -amount : amount)
        if priceType == .Debt {
            people?.debts.append(bill)
            popView()
            return
        }
        
        people?.receivables.append(bill)
        popView()
        return
    }
    
    var getFriends: [People]? {
        let friends = people?.friends ?? []
        return friends.isEmpty ? nil : friends
    }
    
    var pullDownButtonIsEnabled: Bool {
        !(people?.friends.isEmpty ?? true)
    }
    
    func popView() {
        router?.popView()
    }
    
    func notifyViewLoaded() {
        people = interactor?.readPeople
    }
    
    func notifyViewWillAppear() {
        view?.configureFriendPullDownButton()
        selectedPeople = people?.friends.first
    }
}
