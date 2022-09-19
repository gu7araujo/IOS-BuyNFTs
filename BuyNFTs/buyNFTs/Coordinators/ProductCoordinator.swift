//
//  ProductCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Domain

class ProductCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        let viewController = HomeViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func openDetails(product: Product) {
        let viewController = ProductDetailsViewController(product: product)
        navigationController.present(viewController, animated: true)
    }
}

extension ProductCoordinator: HomeViewModelDelegate {
    func openProductDetails(_ product: Product) {
        openDetails(product: product)
    }
}
