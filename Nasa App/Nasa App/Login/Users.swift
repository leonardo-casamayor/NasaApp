//
//  Users.swift
//  Nasa App
//
//  Created by Julio Ismael Robles on 21/09/2021.
//

import Foundation

struct Users: Codable {
    let username: String
    let password: String
}

typealias UsersList = [Users]

