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

    // MARK: - Public properties

    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }

    // MARK: - Private properties

    private var existsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCase = .init()

    // MARK: - Initialization

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("LoginCoordinator deinit")
    }

    // MARK: - Methods

    func start() {
        if verifyExistsApiToken() {
            self.finish()
        } else {
            showLoginViewController()
        }
    }

    func showLoginViewController() {
        let loginVM = LoginViewModel()
        loginVM.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }
        let loginVC = LoginViewController(loginVM)
        navigationController.pushViewController(loginVC, animated: true)
    }

    func verifyExistsApiToken() -> Bool {
        do {
            try existsTokenInKeyChainUseCase.execute()
            return true
        } catch {
            return false
        }
    }
}
