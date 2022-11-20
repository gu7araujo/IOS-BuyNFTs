//
//  LoginCompositionRoot.swift
//  Login
//
//  Created by Gustavo Araujo Santos on 19/11/22.
//

import Shared

final class LoginCompositionRoot {

    static let shared = LoginCompositionRoot()

    private init() { }

    func buildLoginUseCase() -> LoginUseCaseProtocol {
        let repository = SharedCompositionRoot.shared.buildUserRepository()
        let useCase = LoginUseCase(useRepository: repository)
        return useCase
    }

    func buildLoginViewModel() -> LoginViewModel {
        let loginUseCase = buildLoginUseCase()
        let saveTokenUseCase = SharedCompositionRoot.shared.buildSaveTokenInKeyChainUseCase()
        let vm = LoginViewModel(loginUseCase: loginUseCase,
                                saveTokenUseCase: saveTokenUseCase)
        return vm
    }

}
