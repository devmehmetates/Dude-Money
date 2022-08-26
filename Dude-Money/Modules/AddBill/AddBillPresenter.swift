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
    func addBill(whose: String?, amount: Double?, type: PriceType)
    var getFriends: [People]? { get }
   
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
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, interactor: AddBillInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddBillPresenter: AddBillPresenterInterface {
    func addBill(whose: String?, amount: Double?, type: PriceType) {
        guard let whose = whose, let amount = amount else { return }

        let bill = Bill(whose: whose, ammount: type == .Debt ? -amount : amount)
        if type == .Debt {
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
        !(people?.friends.isEmpty ?? false)
    }
    
    func popView() {
        router?.popView()
    }
    
    func notifyViewLoaded() {
        people = interactor?.readPeople
    }
    
    func notifyViewWillAppear() {
        view?.configureFriendPullDownButton()
        view?.configureSelectedPeople()
    }
}
