//
//  MainCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let child = LoginCoordinator(navigationController)
        child.delegate = self
        children.append(child)
        child.start()
    }

    func removeChild(_ child: Coordinator?) {
        guard let index = children.firstIndex(where: { $0 === child }) else { return }
        children.remove(at: index)
    }

    private func startProductCoordinator() {
        navigationController.delegate = self
        let child = ProductCoordinator(navigationController)
        children.append(child)
        child.start()
    }
}

extension MainCoordinator: LoginCoordinatorDelegate {
    func navigateToHome(_ child: Coordinator?) {
        removeChild(child)
        startProductCoordinator()
    }
}
