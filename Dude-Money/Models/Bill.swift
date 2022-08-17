//
//  Bill.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 16.08.2022.
//

struct Bill: Codable {
    var whose: String
    var ammount: Double
    
    static let exampleModel: Bill = Bill(whose: "friend", ammount: 100)
}
