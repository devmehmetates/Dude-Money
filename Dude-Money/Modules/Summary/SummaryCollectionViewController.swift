//
//  SummaryCollectionViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 16.08.2022.
//

import UIKit

protocol SummaryViewInterface: AnyObject {
    func setupView()
    func setupToolbar()
}

class SummaryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: SummaryPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCollectionViewCell.cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 100, height: 100)
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
