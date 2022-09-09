//
//  ProductCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit

class ProductCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
