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

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BillTableViewCell? = BillTableViewCell()
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryTableViewCell
            cell?.setBalance = presenter?.people?.balance
            return cell ?? UITableViewCell()
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as? BillTableViewCell
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
                cell?.setNameLabel = "Alınacak para kalmamış kanka"
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
                cell?.setNameLabel = "Borç mu? O da ne!"
                cell?.setProfileImageWithSystemName =  "hands.sparkles"
            }
        }
        
        guard let cell = cell else {
            return UITableViewCell()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 1:
            return "Alınacaklar 🤑"
            
        case 2:
            return "Borçlar 🥲"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 210
        } else {
            return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeConfiguration: UISwipeActionsConfiguration = UISwipeActionsConfiguration()
        
        if indexPath.section == 1, !(presenter?.people?.receivables.isEmpty ?? false) {
            let gainAction = createGainAction(indexPath: indexPath)
            gainAction.title = "Alındı İşaretle"
            gainAction.backgroundColor = .systemGreen
            swipeConfiguration = UISwipeActionsConfiguration(actions: [gainAction])
        } else if indexPath.section == 2, !(presenter?.people?.debts.isEmpty ?? false) {
            let deptAction = createGainAction(indexPath: indexPath)
            deptAction.title = "Öde"
            deptAction.backgroundColor = .systemRed
            swipeConfiguration = UISwipeActionsConfiguration(actions: [deptAction])
        }
        
        swipeConfiguration.performsFirstActionWithFullSwipe = false
        return swipeConfiguration
    }
    
    private func createGainAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            completionHandler(true)
        }
    }
    
    private func createDeptAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            completionHandler(true)
        }
    }
}

// MARK: - Interface setup
extension SummaryTableViewController: SummaryViewInterface {
    
    func setupToolbar() {
        let addButton = UIBarButtonItem(systemItem: .add)
        self.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addAction)
        
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
        self.title = "Borçların"
    }
}

extension Double {
    var format: String { return String(format: "%0.2f", self)}
}
