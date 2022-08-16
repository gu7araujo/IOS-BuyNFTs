//
//  Customer.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

import Foundation

public struct Customer: User, Decodable {
    let id: Int
    let name: String
    let token: String
    let wallet: String
}
