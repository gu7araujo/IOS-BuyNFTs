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

final class LoginUseCase: LoginUseCaseProtocol {
    init() { }

    func execute(userName: String, password: String) throws -> String {
        // do call to api here

        if true {
            throw LoginError.notFound
        }

        let token = ""

        return token
    }
}
