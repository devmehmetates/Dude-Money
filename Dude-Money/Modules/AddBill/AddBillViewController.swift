//
//  AddBillViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import UIKit

protocol AddBillViewInterface: AnyObject {
    func createFriendUIActions(_ friends: [People]?) -> [UIMenuElement]
}

class AddBillViewController: UIViewController {

    var presenter: AddBillPresenter?
    @IBOutlet var friendPullDownButton: UIButton!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    var priceType: Int = 0
    var selectedPeople: People?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
        friendPullDownButton.showsMenuAsPrimaryAction = true
        friendPullDownButton.changesSelectionAsPrimaryAction = true
        
        friendPullDownButton.menu = UIMenu(children: createFriendUIActions(presenter?.getFriends))
        friendPullDownButton.isEnabled = presenter?.pullDownButtonIsEnabled ?? false
        selectedPeople = presenter?.getFriends?.first
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        presenter?.popView()
    }
    @IBAction func priceTypeValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            priceTextField.textColor = .systemGreen
            priceTextField.tintColor = .systemGreen
            addButton.tintColor = .systemGreen
            friendPullDownButton.tintColor = .systemGreen
            priceType = 1
        } else {
            priceTextField.textColor = .systemRed
            priceTextField.tintColor = .systemRed
            addButton.tintColor = .systemRed
            friendPullDownButton.tintColor = .systemRed
            priceType = 0
        }
    }
    @IBAction func addButtonTapped(_ sender: Any) {
        print(selectedPeople?.username, priceTextField.text, priceType)
    }
}

extension AddBillViewController: AddBillViewInterface {
    func createFriendUIActions(_ friends: [People]?) -> [UIMenuElement] {
        var friendActions: [UIMenuElement] = []
        guard let friends = friends else {
            return [UIAction(title: "Hiç arkadaş yok!", state: .off, handler: { _ in })]
        }

        for friend in friends {
            let action = UIAction(title: friend.fullName + " (\(friend.username))", state: .on, handler: { _ in
                self.selectedPeople = friend
            })
            friendActions.append(action)
        }
        return friendActions
    }
}
