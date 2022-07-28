//
//  Customer.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

import Foundation

struct Customer: User {
    let id: Int
    let name: String
    let username: String
    var password: String
    var wallet: String?
}
