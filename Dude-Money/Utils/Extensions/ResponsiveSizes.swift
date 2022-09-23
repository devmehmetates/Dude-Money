//
//  ResponsiveSizes.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 17.08.2022.
//

import UIKit

extension Double {
    var responsiveW: Double { return (UIScreen.main.bounds.size.width) * self / 100 }
    var responsiveH: Double { return (UIScreen.main.bounds.size.height) * self / 100 }
}
