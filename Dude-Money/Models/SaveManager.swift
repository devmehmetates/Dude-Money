//
//  SaveService.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 15.08.2022.
//

import Foundation

protocol SaveManagerInterface: AnyObject {
    func saveUser(_ people: People)
    func readUser() -> People?
}

final class SaveManager: SaveManagerInterface {
    
    static let shared: SaveManager = SaveManager()
    let userDataKey: String = "userData"
    
    func saveUser(_ people: People) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(userDataKey)
            
            do {
                if let encoded = try? JSONEncoder().encode(people) { try encoded.write(to: fileURL) }
            } catch {
                print("save error")
            }
        }
    }
    
    func readUser() -> People? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(userDataKey)
            do{
                let stringContent = try String(contentsOf: fileURL, encoding: .utf8)
                if let decoded = try? JSONDecoder().decode(People.self, from: stringContent.data(using: .utf8) ?? Data()) {
                    return decoded
                }
            } catch{
                print("read error")
                // TODO: When register logic setted remove it
                return People.exampleModel
            }
        }
        return People.exampleModel
    }
}
