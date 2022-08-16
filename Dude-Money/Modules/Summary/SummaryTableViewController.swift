//
//  SummaryTableViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 15.08.2022.
//

import UIKit

protocol SummaryViewInterface {
    func setupView()
    func setupToolbar()
}

class SummaryTableViewController: UITableViewController {
    
    var presenter: SummaryPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Interface setup
extension SummaryTableViewController: SummaryViewInterface {
    
    func setupToolbar() {
        configureRightNavigationBarButton()
        configureLeftNavigationBarButton()
    }
    
    private func configureRightNavigationBarButton() {
        let addButton = UIBarButtonItem(systemItem: .add)
        self.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addAction)
    }
    
    private func configureLeftNavigationBarButton() {
        let profileIcon = UIImageView(image: UIImage(named: presenter?.people?.icon ?? ""))
        profileIcon.image = profileIcon.image?.withRenderingMode(.alwaysOriginal)
        profileIcon.backgroundColor = .systemRed
        profileIcon.layer.cornerRadius = 20
        NSLayoutConstraint.activate([
            profileIcon.widthAnchor.constraint(equalToConstant: 40),
            profileIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileIcon)
    }
    
    @objc
    func addAction() {
//        presenter?.router?.performSegue(with: "addAction")
        presenter?.people?.debts.append(Bill(whose: "friend", ammount: Double.random(in: (-1000)...(-500))))
        presenter?.people?.receivables.append(Bill(whose: "friend", ammount: Double.random(in: 500...1000)))
        tableView.reloadData()
    }
    
    func setupView() {
        self.title = ScreenTexts.summaryScreenTitle
    }
}

// MARK: - TableViewCell Configuration
extension SummaryTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BillTableViewCell? = BillTableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.cellId, for: indexPath) as? SummaryTableViewCell
            cell?.setBalance = presenter?.people?.balance
            return cell ?? UITableViewCell()
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: BillTableViewCell.cellId, for: indexPath) as? BillTableViewCell
        }
        
        var bill: Bill?
        var friend: People?
        
        if indexPath.section == 1 {
            if presenter?.people?.receivables.count ?? 0 > indexPath.row {
                bill = presenter?.people?.receivables[indexPath.row]
                friend = presenter?.people?.friends.first { $0.username == bill?.whose }
            }
            
            if let bill = bill, let friend = friend {
                cell?.setAmountLabel = bill.ammount
                cell?.setNameLabel = (friend.name) + " " + (friend.surname)
                cell?.setProfileImageWithNamed = friend.icon
                cell?.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            } else {
                cell?.setAmountLabel = nil
                cell?.setNameLabel = ScreenTexts.emptyReceivablesText
                cell?.setProfileImageWithSystemName = "hand.thumbsdown"
            }
        } else if indexPath.section == 2 {
            if presenter?.people?.debts.count ?? 0 > indexPath.row {
                bill = presenter?.people?.debts[indexPath.row]
                friend = presenter?.people?.friends.first { $0.username == bill?.whose }
            }
            
            if let bill = bill, let friend = friend {
                cell?.setAmountLabel = bill.ammount
                cell?.setNameLabel = (friend.name) + " " + (friend.surname)
                cell?.setProfileImageWithNamed = friend.icon
                cell?.backgroundColor = .systemRed.withAlphaComponent(0.2)
            } else {
                cell?.setAmountLabel = nil
                cell?.setNameLabel = ScreenTexts.emptyDebtText
                cell?.setProfileImageWithSystemName = "hands.sparkles"
            }
        }
        
        guard let cell = cell else {
            return UITableViewCell()
        }

        return cell
    }
}

// MARK: - TableViewCell Sections and Counts Configuration
extension SummaryTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int { 3 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return (presenter?.people?.receivables.isEmpty ?? false) ? 1 : presenter?.people?.receivables.count ?? 0
        case 2:
            return (presenter?.people?.debts.isEmpty ?? false) ? 1 : presenter?.people?.debts.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 1:
            return ScreenTexts.receivablesSectionTitle
        case 2:
            return ScreenTexts.debtSectionTitle
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return SummaryTableViewCell.cellHeight
        } else {
            return BillTableViewCell.cellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 30 }
}

// MARK: - TableViewCell SwipeActionsConfiguration
extension SummaryTableViewController {
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeConfiguration: UISwipeActionsConfiguration = UISwipeActionsConfiguration()
        
        if indexPath.section == 1, !(presenter?.people?.receivables.isEmpty ?? false) {
            let gainAction = createGainAction(indexPath: indexPath)
            gainAction.title = ScreenTexts.receivablesSwipeActionText
            gainAction.backgroundColor = .systemGreen
            swipeConfiguration = UISwipeActionsConfiguration(actions: [gainAction])
        } else if indexPath.section == 2, !(presenter?.people?.debts.isEmpty ?? false) {
            let deptAction = createGainAction(indexPath: indexPath)
            deptAction.title = ScreenTexts.debtSwipeActionText
            deptAction.backgroundColor = .systemRed
            swipeConfiguration = UISwipeActionsConfiguration(actions: [deptAction])
        }
        
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        return swipeConfiguration
    }
    
    private func createGainAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            // TODO: Gain Action
            completionHandler(true)
        }
    }
    
    private func createDeptAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: nil) { (_, _, completionHandler) in
            // TODO: Dept Action
            completionHandler(true)
        }
    }
}
