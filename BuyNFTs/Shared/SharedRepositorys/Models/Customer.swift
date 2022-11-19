//
//  Customer.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 18/11/22.
//

public struct Customer: User, Decodable {
    public let id: Int
    public let name: String
    public let token: String
    public let wallet: String

    public init(id: Int,
                name: String,
                token: String,
                wallet: String) {
        self.id = id
        self.name = name
        self.token = token
        self.wallet = wallet
    }
}
