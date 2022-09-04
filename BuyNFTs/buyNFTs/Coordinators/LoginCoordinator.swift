//
//  LoginCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Security
import Domain

class LoginCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.readTokenInKeyChainUseCase = ReadTokenInKeyChainUseCase()
    }

    func start() {
        if verifyExistsToken() {
            // if exists valid token in key chain, go to Home
        } else {
            navigationController.delegate = self
            let viewModel = LoginViewModel()
            let viewController = LoginViewController(viewModel)
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    func verifyExistsToken() -> Bool {
        do {
            _ = try readTokenInKeyChainUseCase.execute()
            return true
        } catch {
            return false
        }
    }

}
