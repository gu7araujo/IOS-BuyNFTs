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
    func execute(userName: String, password: String) throws -> String
}

class LoginUseCase: LoginUseCaseProtocol {

    init() { }

    func execute(userName: String, password: String) throws -> String {
        // do call api here

        if true {
            throw LoginError.notFound
        }

        let token = ""

        return token
    }
}
