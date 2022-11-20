//
//  HomeCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Shared

public protocol HomeCoordinatorProtocol: CoordinatorProtocol {
    func showProductDetails(_ product: Product)
}

public class HomeCoordinator: HomeCoordinatorProtocol {

    // MARK: - Properties

    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var navigationController: UINavigationController
    public var childCoordinators: [CoordinatorProtocol] = []
    public var type: CoordinatorType { .home }

    // MARK: - Initialization

    required public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("HomeCoordinator deinit")
    }

    // MARK: - Methods

    public func start() {
        let homeVM = HomeCompositionRoot.shared.buildHomeViewModel()
        let homeVC = HomeCompositionRoot.shared.buildHomeViewController(homeVM)
        homeVC.didSendEventsClosure = { event in
            switch event {
            case CryptosCell.Event.openCryptoDetails(let product): self.showProductDetails(product)
            case NftCell.Event.openNftDetails(let product): self.showProductDetails(product)
            default: break
            }
        }
        navigationController.pushViewController(homeVC, animated: true)
    }

    public func showProductDetails(_ product: Product) {
        let productDetailsVC = HomeCompositionRoot.shared.buildProductDetailsViewController(product: product)
        navigationController.present(productDetailsVC, animated: true)
    }
}
