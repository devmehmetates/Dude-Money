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

final class SummaryViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    var presenter: SummaryPresenterInterface = SummaryPresenter(view: nil, router: nil, interactor: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.notifyViewLoaded()
        collectionView.registerCell(cell: BillCollectionViewCell.self)
        collectionView.registerCell(cell: SummaryCollectionViewCell.self)
        collectionView.registerReusableView(cell: HeaderCollectionReusableView.self)
    }
}

// MARK: - Index Constants
extension SummaryViewController {
    
    static let summarySectionIndex: Int = 0
    static let receivablesSectionIndex: Int = 1
    static let debtSectionIndex: Int = 2
}

// MARK: - Size Constants
extension SummaryViewController {
    
    // MARK: Profile Icon
    static let profileIconSize: CGFloat = 40
    static let profileIconCornerRadius: CGFloat = 20
    
    // MARK: Main Cells
    static let cellWidth: CGFloat = 90.0.responsiveW
    
    // MARK: Header View
    static let headerWidth: CGFloat = 100.0.responsiveW
    static let headerHeight: CGFloat = 50
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
            configuration.backgroundColor = .secondarySystemBackground
            
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
        self.title = ScreenTexts.summaryScreenTitle
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
        let profileIcon = UIImageView(image: UIImage(named: presenter.getUserProfileIcon))
        profileIcon.image = profileIcon.image?.withRenderingMode(.alwaysOriginal)
        profileIcon.backgroundColor = .systemRed
        profileIcon.layer.cornerRadius = SummaryViewController.profileIconCornerRadius
        NSLayoutConstraint.activate([
            profileIcon.widthAnchor.constraint(equalToConstant: SummaryViewController.profileIconSize),
            profileIcon.heightAnchor.constraint(equalToConstant: SummaryViewController.profileIconSize)
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
        guard let cell: BillCollectionViewCell = collectionView.dequeue(for: indexPath) else { return UICollectionViewCell() }
        
        // MARK: SummaryCell
        if indexPath.section == SummaryViewController.summarySectionIndex {
            guard let cell: SummaryCollectionViewCell = collectionView.dequeue(for: indexPath) else { return UICollectionViewCell() }
            cell.contentView.heightAnchor.constraint(equalToConstant: SummaryCollectionViewCell.cellHeight).isActive = true
            cell.configureContent(amount: presenter.getUserBalance)
            return cell
            
        }
        // MARK: ReceiavablesCell
        else if indexPath.section == SummaryViewController.receivablesSectionIndex {
            cell.contentView.heightAnchor.constraint(equalToConstant: BillCollectionViewCell.cellHeight).isActive = true
            
            if let cellData = presenter.getReceivablesDataByIndex(indexPath.row) {
                cell.configureContents(friend: cellData.friend, bill: cellData.bill)
            } else {
                cell.configureContents(infoCell: (icon: "hand.thumbsdown", message: ScreenTexts.emptyReceivablesText))
            }
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            return cell
        }
        // MARK: DebtsCell
        else {
            cell.contentView.heightAnchor.constraint(equalToConstant: BillCollectionViewCell.cellHeight).isActive = true
            
            if let cellData = presenter.getDebtDataByIndex(indexPath.row) {
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
        case SummaryViewController.receivablesSectionIndex:
            return presenter.getReceivablesCount
        case SummaryViewController.debtSectionIndex:
            return presenter.getDebtsCount
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.getSectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == SummaryViewController.summarySectionIndex {
            return CGSize(width: SummaryViewController.cellWidth, height: SummaryCollectionViewCell.cellHeight)
        }
        return CGSize(width: SummaryViewController.cellWidth, height: BillCollectionViewCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == SummaryViewController.summarySectionIndex {
            return .zero
        }

        return CGSize(width: SummaryViewController.headerWidth, height: SummaryViewController.headerHeight)
    }
}

// MARK: - CollectionView Header Setup
extension SummaryViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView: HeaderCollectionReusableView = collectionView.dequeueReusableView(for: indexPath, kind: kind) else {
                return UICollectionReusableView()
            }
            
            if indexPath.section == SummaryViewController.receivablesSectionIndex {
                headerView.setHeaderLabel(ScreenTexts.receivablesSectionTitle)
            } else if indexPath.section == SummaryViewController.debtSectionIndex {
                headerView.setHeaderLabel(ScreenTexts.debtSectionTitle)
            }
            
            headerView.heightAnchor.constraint(equalToConstant: HeaderCollectionReusableView.cellHeight).isActive = true
            return headerView
        default:
          assert(false, "Invalid element type")
        }
    }
}

// MARK: - Cell Swipe Actions
extension SummaryViewController {
    
    func createSwipeAction(forSection section: Int) -> [UIContextualAction] {
        let swipeAction: UIContextualAction?
        
        if section == SummaryViewController.receivablesSectionIndex, !presenter.getReceivablesIsEmpty {
            swipeAction = UIContextualAction(style: .normal, title: ScreenTexts.receivablesSwipeActionText) { action, sourceView, actionPerformed in
                actionPerformed(true)
            }
            swipeAction?.backgroundColor = .systemGreen
        } else if section == SummaryViewController.debtSectionIndex, !presenter.getDebtIsEmpty {
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
