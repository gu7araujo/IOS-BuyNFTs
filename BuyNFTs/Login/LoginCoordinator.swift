//
//  LoginCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Shared

public protocol LoginCoordinatorProtocol: CoordinatorProtocol {
    init(_ navigationController: UINavigationController,
              existsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCaseProtocol)
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

    private var existsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCaseProtocol?

    // MARK: - Initialization

    public required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public required init(_ navigationController: UINavigationController,
                         existsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCaseProtocol) {
        self.navigationController = navigationController
        self.existsTokenInKeyChainUseCase = existsTokenInKeyChainUseCase
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

    public func showLoginViewController() {
        let loginVM = LoginCompositionRoot.shared.buildLoginViewModel()
        loginVM.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }
        let loginVC = LoginViewController(loginVM)
        navigationController.pushViewController(loginVC, animated: true)
    }

    public func verifyExistsApiToken() -> Bool {
        do {
            try existsTokenInKeyChainUseCase?.execute()
            return true
        } catch {
            return false
        }
    }
}
