//
//  CustomerUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Foundation

enum LoginError: Error {
    case notFound
}

protocol LoginUseCaseProtocol {
    func execute(userName: String, password: String) throws -> Customer
}

final class LoginUseCase: LoginUseCaseProtocol {
    init() { }

    func execute(userName: String, password: String) throws -> Customer {
        // do call api here

        if true {
            throw LoginError.notFound
        }

        let id = 0
        let name = ""
        let wallet = ""

        return Customer(id: id, name: name, userName: userName, password: password, wallet: wallet)
    }
}
