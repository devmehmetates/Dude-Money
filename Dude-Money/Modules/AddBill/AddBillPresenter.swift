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
}

final class AddBillPresenter {
    
    private weak var view: AddBillViewInterface?
    private var router: AddBillRouterInterface? // same issue
    private weak var interactor: AddBillInteractorInterface?
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, interactor: AddBillInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddBillPresenter: AddBillPresenterInterface {
    func popView() {
        router?.popView()
    }
    
    func notifyViewLoaded() {
        
    }
    
    func notifyViewWillAppear() {
        
    }
}

