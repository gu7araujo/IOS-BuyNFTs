//
//  CustomerUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Domain

enum LoginError: Error {
    case notFound
}

protocol LoginUseCaseProtocol {
    func execute(userName: String, password: String) async -> Result<String, Error>
}

class LoginUseCase: LoginUseCaseProtocol {

    private var userRepository: UserRepositoryProtocol

    init() {
        self.userRepository = UserRepository()
    }

    func execute(userName: String, password: String) async -> Result<String, Error> {
        let result = await userRepository.get(userName: userName, password: password)

        switch result {
        case .success(let user):
            return .success(user.token)
        case .failure(_):
            return .failure(LoginError.notFound)
        }
    }
}
