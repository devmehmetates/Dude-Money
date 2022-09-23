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
    
    static let exampleModel = People(
        username: "example",
        name: "example",
        surname: "example",
        icon: "example4",
        balance: 100,
        friends: [
            exampleFriend
        ],
        debts: [
            Bill(whose: "friend", ammount: 100),
            Bill(whose: "friend", ammount: 200),
            Bill(whose: "friend", ammount: 300)
        ],
        receivables: [
            Bill(whose: "friend", ammount: 100),
            Bill(whose: "friend", ammount: 200),
            Bill(whose: "friend", ammount: 300)
        ]
    )
    
    static let exampleFriend = People(
        username: "friend",
        name: "Friend",
        surname: "Friend",
        icon: "example3",
        balance: 0,
        friends: [],
        debts: [],
        receivables: []
    )
}
