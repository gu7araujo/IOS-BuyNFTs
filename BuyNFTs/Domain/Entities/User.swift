//
//  User.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

protocol User {
    var id: Int { get }
    var name: String { get }
    var token: String { get }
}
