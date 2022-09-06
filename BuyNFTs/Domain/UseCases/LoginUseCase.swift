//
//  CustomerUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Foundation

enum LoginError: Error {
    case userNotFound
}

extension LoginError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userNotFound:
            return NSLocalizedString("Credentials not found..", comment: "Login Error")
        }
    }
}

public protocol LoginUseCaseProtocol {
    func execute(userName: String, password: String) async -> Result<String, Error>
}

public class LoginUseCase: LoginUseCaseProtocol {

    private var userRepository: UserRepositoryProtocol

    public init() {
        self.userRepository = UserRepository()
    }

    public func execute(userName: String, password: String) async -> Result<String, Error> {
        let result = await userRepository.get(userName: userName, password: password)

        switch result {
        case .success(let user):
            return .success(user.token)
        case .failure(_):
            return .failure(LoginError.userNotFound)
        }
    }
}
