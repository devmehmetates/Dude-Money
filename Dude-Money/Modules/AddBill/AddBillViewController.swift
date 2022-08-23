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
    @IBOutlet var friendPullDownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendPullDownButton.showsMenuAsPrimaryAction = true
        friendPullDownButton.changesSelectionAsPrimaryAction = true

        
        friendPullDownButton.menu = UIMenu(children: [
            UIAction(title: "Deneme", state: .on, handler: { action in
                
            }),
            UIAction(title: "Deneme2", state: .on, handler: { action in
                
            }),
            UIAction(title: "Deneme3", state: .on, handler: { action in
                
            }),
            UIAction(title: "Deneme4", state: .on, handler: { action in
                
            }),
        ])
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presenter?.popView()
    }
}

extension AddBillViewController: AddBillViewInterface {
    
}
