//
//  AddBillViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 19.08.2022.
//

import UIKit

protocol AddBillViewInterface: AnyObject {
    func createFriendUIActions(_ friends: [People]?) -> [UIMenuElement]
    func configureFriendPullDownButton()
    func configurePriceTpyeSegmentedControlByDebt()
    func configurePriceTpyeSegmentedControlByReceivable()
}

final class AddBillViewController: UIViewController {
    @IBOutlet weak private var friendPullDownButton: UIButton!
    @IBOutlet weak private var priceTextField: UITextField!
    @IBOutlet weak private var addButton: UIButton!
    
    var presenter: AddBillPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.notifyViewWillAppear()
    }
}

// MARK: - Interface Setup
extension AddBillViewController: AddBillViewInterface {
    
    func createFriendUIActions(_ friends: [People]?) -> [UIMenuElement] {
        var friendActions: [UIMenuElement] = []
        guard let friends = friends else {
            return [UIAction(title: "Hiç arkadaş yok!", state: .off, handler: { _ in })]
        }

        for friend in friends {
            let action = UIAction(title: friend.fullName + " (\(friend.username))", state: .on, handler: { [weak self] _ in
                self?.presenter.selectFriend(friend)
            })
            friendActions.append(action)
        }
        return friendActions
    }
    
    func configurePriceTpyeSegmentedControlByDebt() {
        priceTextField.textColor = .systemRed
        priceTextField.tintColor = .systemRed
        addButton.tintColor = .systemRed
        friendPullDownButton.tintColor = .systemRed
    }
    
    func configurePriceTpyeSegmentedControlByReceivable() {
        priceTextField.textColor = .systemGreen
        priceTextField.tintColor = .systemGreen
        addButton.tintColor = .systemGreen
        friendPullDownButton.tintColor = .systemGreen
    }
}

// MARK: - Configure Content
extension AddBillViewController {
    func configureFriendPullDownButton() {
        friendPullDownButton.showsMenuAsPrimaryAction = true
        friendPullDownButton.changesSelectionAsPrimaryAction = true
        
        friendPullDownButton.menu = UIMenu(children: createFriendUIActions(presenter.getFriends))
        friendPullDownButton.isEnabled = presenter.pullDownButtonIsEnabled
    }
}

// MARK: - IBActions
extension AddBillViewController {
    @IBAction private func closeButtonTapped(_ sender: UIButton) {
        presenter.popView()
    }
    
    @IBAction private func priceTypeValueChanged(_ sender: UISegmentedControl) {
        presenter.priceTpyeValueChanged(sender.selectedSegmentIndex)
    }
    
    @IBAction private func addButtonTapped(_ sender: Any) {
        presenter.addBill(amount: priceTextField.text)
    }
}

enum PriceType: Int {
    case Debt
    case Receivable
}
