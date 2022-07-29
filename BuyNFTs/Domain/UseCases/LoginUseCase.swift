//
//  CustomerUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Foundation

protocol LoginUseCaseProtocol {
    func execute(userName: String, password: String) -> Customer
}

final class LoginUseCase: LoginUseCaseProtocol {
    init() { }

    func execute(userName: String, password: String) -> Customer {
        // do call api here

        let id = 0
        let name = ""
        let wallet = ""

        return Customer(id: id, name: name, userName: userName, password: password, wallet: wallet)
    }
}
