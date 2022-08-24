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
    var getFriends: [People]? { get }
}

final class AddBillPresenter {
    
    private weak var view: AddBillViewInterface?
    private var router: AddBillRouterInterface?
    private var interactor: AddBillInteractorInterface?
    private var people: People?
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, interactor: AddBillInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddBillPresenter: AddBillPresenterInterface {
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
    }
}

