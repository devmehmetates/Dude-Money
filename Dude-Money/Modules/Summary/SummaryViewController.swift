//
//  SummaryViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 17.08.2022.
//

import UIKit

protocol SummaryViewInterface: AnyObject {
    func setupView()
    func setupToolbar()
    func createLayout() -> UICollectionViewCompositionalLayout
}

class SummaryViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    var presenter: SummaryPresenterInterface?
    
    let summarySectionIndex: Int = 0
    let receivablesSectionIndex: Int = 1
    let debtSectionIndex: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
}

// MARK: - Interface Setup
extension SummaryViewController: SummaryViewInterface {
    
    func setupView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            
            switch index {
            case 1...2:
                configuration.headerMode = .supplementary
                configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
                    return .init(actions: self.createSwipeAction(forSection: indexPath.section))
                }
                return .list(using: configuration, layoutEnvironment: environment)
            default:
                configuration.headerMode = .none
                return .list(using: configuration, layoutEnvironment: environment)
            }
        }
        return layout
    }
    
    func setupToolbar() {
        self.title = "Borçların"
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
        let profileIcon = UIImageView(image: UIImage(named: presenter?.getUserProfileIcon() ?? ""))
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
    }
}

// MARK: - CollectionView Cells and DataSource
extension SummaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: SummaryCell
        if indexPath.section == summarySectionIndex {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.cellId, for: indexPath)
                    as? SummaryCollectionViewCell else { return UICollectionViewCell() }
            cell.contentView.heightAnchor.constraint(equalToConstant: SummaryCollectionViewCell.cellHeight).isActive = true
            cell.configureContent(amount: presenter?.getUserBalance() ?? 0)
            return cell
            
        }
        // MARK: ReceiavablesCell
        else if indexPath.section == receivablesSectionIndex {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCollectionViewCell.cellId, for: indexPath)
                    as? BillCollectionViewCell else { return UICollectionViewCell() }
            
            cell.contentView.heightAnchor.constraint(equalToConstant: BillCollectionViewCell.cellHeight).isActive = true
            
            if let cellData = presenter?.getReceivablesDataByIndex(indexPath.row) {
                cell.configureContents(friend: cellData.friend, bill: cellData.bill)
            } else {
                cell.configureContents(infoCell: (icon: "hand.thumbsdown", message: ScreenTexts.emptyReceivablesText))
            }
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            return cell
        }
        // MARK: DebtsCell
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCollectionViewCell.cellId, for: indexPath)
                    as? BillCollectionViewCell else { return UICollectionViewCell() }
            
            cell.contentView.heightAnchor.constraint(equalToConstant: BillCollectionViewCell.cellHeight).isActive = true
            
            if let cellData = presenter?.getDebtDataByIndex(indexPath.row) {
                cell.configureContents(friend: cellData.friend, bill: cellData.bill)
            } else {
                cell.configureContents(infoCell: (icon: "hands.sparkles", message: ScreenTexts.emptyDebtText))
            }
            cell.backgroundColor = .systemRed.withAlphaComponent(0.2)
            return cell
        }
    }
}

// MARK: - CollectionView Cell count and size
extension SummaryViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return presenter?.getReceivablesCount() ?? 0
        case 2:
            return presenter?.getDebtsCount() ?? 0
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter?.getSectionCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 90.0.responsiveW, height: SummaryCollectionViewCell.cellHeight)
        }
        return CGSize(width: 90.0.responsiveW, height: BillCollectionViewCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }

        return CGSize(width: 100.0.responsiveW, height: 50)
    }
}

// MARK: - CollectionView Header Setup
extension SummaryViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.cellId, for: indexPath)
            guard let reusableHeaderView = headerView as? HeaderCollectionReusableView else { return headerView }
            
            if indexPath.section == 1 {
                reusableHeaderView.setHeaderLabel(ScreenTexts.receivablesSectionTitle)
            } else if indexPath.section == 2 {
                reusableHeaderView.setHeaderLabel(ScreenTexts.debtSectionTitle)
            }
            
            reusableHeaderView.heightAnchor.constraint(equalToConstant: HeaderCollectionReusableView.cellHeight).isActive = true
            return reusableHeaderView
        default:
          assert(false, "Invalid element type")
        }
    }
}

// MARK: - Cell Swipe Actions
extension SummaryViewController {
    
    func createSwipeAction(forSection section: Int) -> [UIContextualAction] {
        let swipeAction: UIContextualAction?
        guard let receivablesIsEmpty = presenter?.getReceivablesIsEmpty() else { return [] }
        guard let debtIsEmpty = presenter?.getDebtIsEmpty() else { return [] }
        
        if section == receivablesSectionIndex, !receivablesIsEmpty {
            swipeAction = UIContextualAction(style: .normal, title: ScreenTexts.receivablesSwipeActionText) { action, sourceView, actionPerformed in
                actionPerformed(true)
            }
            swipeAction?.backgroundColor = .systemGreen
        } else if section == debtSectionIndex, !debtIsEmpty {
            swipeAction = UIContextualAction(style: .normal, title: ScreenTexts.debtSwipeActionText) { action, sourceView, actionPerformed in
                actionPerformed(true)
            }
            swipeAction?.backgroundColor = .systemRed
        } else {
            swipeAction = nil
        }
        
        guard let swipeAction = swipeAction else {
            return []
        }
        
        return [swipeAction]
    }
}
