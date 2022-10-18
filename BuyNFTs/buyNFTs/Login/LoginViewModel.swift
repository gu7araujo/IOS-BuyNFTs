//
//  ViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import Foundation
import Domain

class LoginViewModel {

    // MARK: - Public properties

    @Published var error: String?
    var didSendEventClosure: ((LoginViewModel.Event) -> Void)?

    // MARK: - Private properties

    private let loginUseCase: LoginUseCaseProtocol
    private let saveTokenUseCase: SaveTokenInKeyChainUseCaseProtocol

    // MARK: - Initialization

    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase(), saveTokenUseCase: SaveTokenInKeyChainUseCaseProtocol = SaveTokenInKeyChainUseCase()) {
        self.loginUseCase = loginUseCase
        self.saveTokenUseCase = saveTokenUseCase
    }

    // MARK: - Public methods

    func doLogin(_ username: String, _ password: String) {
        Task {
            do {
                let tokenResult = try await loginUseCase.execute(userName: username, password: password)
                saveToken(username: username, token: tokenResult)
                navigateToHome()
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    // MARK: - Private methods

    private func navigateToHome() {
        DispatchQueue.main.async {
            guard let didSendEventClosure = self.didSendEventClosure else { fatalError("Closure didn't set") }
            didSendEventClosure(.login)
        }
    }

    private func saveToken(username: String, token: String) {
        do {
            try saveTokenUseCase.execute(userName: username, token: token)
        } catch KeyChainError.unsuccessfulSave {
            self.error = KeyChainError.unsuccessfulSave.localizedDescription
        } catch {
            self.error = "Error with token in keychain"
        }
    }
}

extension LoginViewModel {
    enum Event {
        case login
    }
}
