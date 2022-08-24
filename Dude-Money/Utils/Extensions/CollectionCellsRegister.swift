//
//  CollectionCellsRegister.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 24.08.2022.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func registerReusableView<T: UICollectionReusableView>(cell: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: cell))
    }
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: String(describing: T.Type.self), for: indexPath) as? T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(for indexPath: IndexPath, kind: String) -> T? {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.Type.self), for: indexPath) as? T
    }
}
