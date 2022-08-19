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
}

final class AddBillPresenter {
    
    private weak var view: AddBillViewInterface?
    private weak var router: AddBillRouterInterface?
    private weak var interactor: AddBillInteractorInterface?
    
    init(view: AddBillViewInterface?, router: AddBillRouterInterface?, interactor: AddBillInteractorInterface?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension AddBillPresenter: AddBillPresenterInterface {
    func notifyViewLoaded() {
        
    }
    
    func notifyViewWillAppear() {
        
    }
}

