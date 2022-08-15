//
//  People.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 15.08.2022.
//


struct People: Codable {
    var username: String
    var name: String
    var surname: String
    var icon: String
    var balance: Double
    var friends: [People]
    var debts: [Bill]
    var receivables: [Bill]
    
    static let exampleModel = People(username: "example", name: "example", surname: "example", icon: "example1", balance: 0, friends: [], debts: [], receivables: [])
}

struct Bill: Codable {
    var whose: String
    var ammount: Double
}
