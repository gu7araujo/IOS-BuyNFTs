//
//  CustomerUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Foundation
import Shared

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

protocol LoginUseCaseProtocol {
    func execute(userName: String, password: String) async throws -> String
}

class LoginUseCase: LoginUseCaseProtocol {

    private var userRepository: UserRepositoryProtocol

    init(useRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = useRepository
    }

    func execute(userName: String, password: String) async throws -> String {
        do {
            let userResult = try await userRepository.get(userName: userName, password: password)
            return userResult.token
        } catch {
            throw LoginError.userNotFound
        }
    }
}