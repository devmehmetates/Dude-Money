//
//  SummaryCollectionViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 16.08.2022.
//

import UIKit

class SummaryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: SummaryPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
        
        var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfig.headerMode = .supplementary

        listConfig.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
          guard let self = self else { return nil }


          let actionHandler: UIContextualAction.Handler = { action, view, completion in
            completion(true)
            self.collectionView.reloadItems(at: [indexPath])
          }

          let action = UIContextualAction(style: .normal, title: "Done!", handler: actionHandler)
          action.image = UIImage(systemName: "checkmark")
          action.backgroundColor = .systemGreen

          return UISwipeActionsConfiguration(actions: [action])
        }

        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfig)

        collectionView.collectionViewLayout = listLayout
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 3
        case 2:
            return 4
        default:
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.cellId, for: indexPath)
                    as? SummaryCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCollectionViewCell.cellId, for: indexPath)
                    as? BillCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureContents(friend: People.exampleFriend, bill: Bill.exampleModel)
            cell.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillCollectionViewCell.cellId, for: indexPath)
                    as? BillCollectionViewCell else { return UICollectionViewCell() }
            cell.configureContents(friend: People.exampleFriend, bill: Bill.exampleModel)
            cell.backgroundColor = .systemRed.withAlphaComponent(0.2)
            return cell
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        if section == 0 {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//        }
//
//        return UIEdgeInsets.zero
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.section == 0 {
//            return CGSize(width: 90.0.responsiveW, height: SummaryCollectionViewCell.cellHeight)
//        }
//        return CGSize(width: 90.0.responsiveW, height: BillCollectionViewCell.cellHeight)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 0 {
//            return .zero
//        }
//
//        return CGSize(width: 100.0.responsiveW, height: 50)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath)
            guard let reusableHeaderView = headerView as? HeaderCollectionReusableView else { return headerView }
            
            if indexPath.section == 1 {
                reusableHeaderView.setHeaderLabel(ScreenTexts.receivablesSectionTitle)
            } else if indexPath.section == 2 {
                reusableHeaderView.setHeaderLabel(ScreenTexts.debtSectionTitle)
            }
            
            return reusableHeaderView
        default:
          assert(false, "Invalid element type")
        }
    }
}

// MARK: - Interface Setup
extension SummaryCollectionViewController: SummaryViewInterface {
    func setupView() {
        self.title = ScreenTexts.summaryScreenTitle
    }
    
    func setupToolbar() {
        
    }
}
