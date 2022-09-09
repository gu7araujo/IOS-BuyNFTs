//
//  LoginCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Security
import Domain

protocol LoginCoordinatorDelegate: AnyObject {
    func navigateToHome(_ child: Coordinator?)
}

class LoginCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    weak var delegate: LoginCoordinatorDelegate?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.readTokenInKeyChainUseCase = ReadTokenInKeyChainUseCase()
    }

    func start() {
        if verifyExistsToken() {
            delegate?.navigateToHome(self)
        } else {
            navigationController.delegate = self
            let viewModel = LoginViewModel()
            viewModel.delegate = self
            let viewController = LoginViewController(viewModel)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    private func verifyExistsToken() -> Bool {
        do {
            _ = try readTokenInKeyChainUseCase.execute()
            return true
        } catch {
            return false
        }
    }

}

extension LoginCoordinator: LoginViewModelDelegate {
    func loginDone() {
        delegate?.navigateToHome(self)
    }
}
