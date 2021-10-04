//
//  UsersLoader.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 03/10/2021.
//

import Foundation

protocol UserFacade {
    func load() -> Users
    func verifyUserExists(user: Users, fileUser: Users) -> Bool
    func write(user: Users)
}

class UsersLoader: UserFacade {
    var plistURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("Users.plist")
    }
    
    func load() -> Users {
        let decoder = PropertyListDecoder()
        
        guard let data = try? Data.init(contentsOf: plistURL),
              let users = try? decoder.decode(Users.self, from: data)
        else { return Users(username: "", password: "") }
        return users
    }
}
extension UsersLoader {
    func copyUsersFromBundle() {
        if let path = Bundle.main.path(forResource: "Users", ofType: "plist"),
           let data = FileManager.default.contents(atPath: path),
           FileManager.default.fileExists(atPath: plistURL.path) == false {
            
            FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
        }
    }
}
extension UsersLoader {
    
     func verifyUserExists(user: Users, fileUser: Users) -> Bool {
        if user.username == fileUser.username {
            return false
        }
        return true
    }
    
    func write(user: Users) {
        let fileUser = load()
        guard verifyUserExists(user: user, fileUser: fileUser) else {
            print("user already exists")
            return
        }
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(user) {
            if FileManager.default.fileExists(atPath: plistURL.path) {
                // Update an existing plist
                try? data.write(to: plistURL)
            } else {
                // Create a new plist
                FileManager.default.createFile(atPath: plistURL.path, contents: data, attributes: nil)
            }
        }
    }
}
