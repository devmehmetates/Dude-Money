//
//  SafeIndex.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 26.08.2022.
//


extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
