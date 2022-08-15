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
            return presenter?.bills?.filter { $0.ammount > 0 }.count ?? 0
            
        case 2:
            return presenter?.bills?.filter { !($0.ammount > 0) }.count ?? 0
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath)
        }
        
        if indexPath.section == 1 {
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        } else if indexPath.section == 2 {
            cell.backgroundColor = .systemRed.withAlphaComponent(0.2)
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
        
        if indexPath.section == 1 {
            let gainAction = createGainAction(indexPath: indexPath)
            gainAction.title = "Alındı İşaretle"
            gainAction.backgroundColor = .systemGreen
            swipeConfiguration = UISwipeActionsConfiguration(actions: [gainAction])
        } else if indexPath.section == 2 {
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
    }
    
    @objc
    func addAction() {
        presenter?.bills?.append(Bill(whose: "bLA", ammount: 200))
        presenter?.bills?.append(Bill(whose: "bLA", ammount: -200))
        tableView.reloadData()
        print(presenter?.bills)
    }
    
    
    func setupView() {
        self.title = "Borçların"
    }
}
