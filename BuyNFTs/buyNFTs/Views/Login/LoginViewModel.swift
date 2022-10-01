//
//  ViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import Foundation
import Domain

protocol LoginViewModelProtocol {
    var errorPublished: Published<String?> { get }
    var errorPublisher: Published<String?>.Publisher { get }
    func doLogin(_ username: String, _ password: String)
}

class LoginViewModel: LoginViewModelProtocol {

    // MARK: - Public properties

    @Published var error: String?
    var errorPublished: Published<String?> { _error }
    var errorPublisher: Published<String?>.Publisher { $error }

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
            let result = await loginUseCase.execute(userName: username, password: password)

            switch result {
            case .success(let token):
                saveToken(username: username, token: token)
                navigateToHome()
            case .failure(let error):
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
