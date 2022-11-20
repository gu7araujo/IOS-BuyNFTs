//
//  MainCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit
import Shared
import Login

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func showLoginFlow()
    func showMainFlow()
}

class MainCoordinator: MainCoordinatorProtocol {

    // MARK: - Public properties

    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    var type: CoordinatorType { .main }

    // MARK: - Initialization

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("MainCoordinator deinit")
    }

    // MARK: - Methods

    func start() {
        showLoginFlow()
    }

    func showLoginFlow() {
        let loginCoordinator = MainCompositionRoot.shared.buildLoginCoordinator(navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }

    func showMainFlow() {
        let tabCoordinator = MainCompositionRoot.shared.buildTabCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

// MARK: - CoordinatorFinishDelegate
extension MainCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        case .tab:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        default:
            break
        }
    }
}
