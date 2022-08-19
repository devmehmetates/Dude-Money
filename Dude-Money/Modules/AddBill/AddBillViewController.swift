//
//  AddBillViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import UIKit

protocol AddBillViewInterface: AnyObject {
    
}

class AddBillViewController: UIViewController {

    var presenter: AddBillPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddBillViewController: AddBillViewInterface {
    
}
