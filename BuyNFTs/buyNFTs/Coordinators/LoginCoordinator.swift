//
//  LoginCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Domain

protocol LoginCoordinatorProtocol: Coordinator {
    func verifyExistsApiToken() -> Bool
    func showLoginViewController()
}

class LoginCoordinator: LoginCoordinatorProtocol {

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }

    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.readTokenInKeyChainUseCase = ReadTokenInKeyChainUseCase()
    }

    deinit {
        print("LoginCoordinator deinit")
    }

    func start() {
        if verifyExistsApiToken() {
            self.finish()
        } else {
            showLoginViewController()
        }
    }


    func showLoginViewController() {
        let loginVM = LoginViewModel()
        loginVM.didSendEventClosure = { _ in
            self.finish()
        }
        let loginVC = LoginViewController(loginVM)
        navigationController.pushViewController(loginVC, animated: true)
    }

    func verifyExistsApiToken() -> Bool {
        do {
            try readTokenInKeyChainUseCase.execute()
            return true
        } catch {
            return false
        }
    }
}
