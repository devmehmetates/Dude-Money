//
//  BillCollectionViewCell.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 17.08.2022.
//

import UIKit

final class BillCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    func configureContents(
        friend: People? = nil,
        bill: Bill? = nil,
        infoCell: (icon: String?, message: String?)? = (icon: nil, message: nil) ) {
            
        if let infoCell = infoCell {
            self.profileImageView.image = UIImage(systemName: infoCell.icon ?? "")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            self.nameLabel.text = infoCell.message ?? ""
            self.amountLabel.text = ""
        } else {
            guard let friend = friend, let bill = bill else { return }
            self.profileImageView.image = UIImage(named: friend.icon) ?? UIImage(systemName: "person.circle")
            self.nameLabel.text = friend.name + " " + friend.surname
            if bill.ammount != 0 {
                self.amountLabel.text = bill.ammount.format + "₺"
            }
        }
    }
    
    static let cellHeight: CGFloat = 70
}
