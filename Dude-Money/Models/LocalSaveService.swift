//
//  LocalSaveService.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 15.08.2022.
//

import Foundation

final class LocalSaveService {
    
    static func saveUser(_ people: People) {
        let userDataKey = "userData"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(userDataKey)
            
            do {
                if let encoded = try? JSONEncoder().encode(people) { try encoded.write(to: fileURL) }
            } catch {
                print("save error")
            }
        }
    }
    
    static func readUser() -> People? {
        let userDataKey = "userData"
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
