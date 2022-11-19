//
//  LoginCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Shared

protocol LoginCoordinatorProtocol: CoordinatorProtocol {
    func verifyExistsApiToken() -> Bool
    func showLoginViewController()
}

public class LoginCoordinator: LoginCoordinatorProtocol {

    // MARK: - Public properties

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType { .login }

    // MARK: - Private properties

    private var existsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCase = .init()

    // MARK: - Initialization

    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("LoginCoordinator deinit")
    }

    // MARK: - Methods

    public func start() {
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
