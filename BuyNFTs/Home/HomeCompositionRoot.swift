//
//  HomeCompositionRoot.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 20/11/22.
//

import UIKit
import Shared

final class HomeCompositionRoot {

    static let shared = HomeCompositionRoot()

    private init() { }

    /* Repositorys */

    func buildCartRepository() -> CartRepositoryProtocol {
        let userRepository = SharedCompositionRoot.shared.buildUserRepository()
        let repository = CartRepository(userRepository: userRepository)
        return repository
    }

    func buildProductRepository() -> ProductRepositoryProtocol {
        let networkService = SharedCompositionRoot.shared.buildNetworkService()
        let readTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildReadTokenInKeyChainUseCase()
        let repository = ProductRepository(network: networkService,
                                           readTokenInKeyChainUseCase: readTokenInKeyChainUseCase)
        return repository
    }

    /* UseCases */

    func buildAddToCartUseCase() -> AddToCartUseCaseProtocol {
        let cartRepository = buildCartRepository()
        let useCase = AddToCartUseCase(cartRepository: cartRepository)
        return useCase
    }

    func buildCreateCartUseCase() -> CreateCartUseCaseProtocol {
        let cartRepository = buildCartRepository()
        let useCase = CreateCartUseCase(cartRepository: cartRepository)
        return useCase
    }

    func buildListProductsUseCase() -> ListProductsUseCaseProtocol {
        let productRepository = buildProductRepository()
        let useCase = ListProductsUseCase(productRepository: productRepository)
        return useCase
    }

    /* ViewModels */

    func buildHomeViewModel() -> HomeViewModel {
        let listProductsUseCase = buildListProductsUseCase()
        let createCartUseCase = buildCreateCartUseCase()
        let addToCartUseCase = buildAddToCartUseCase()
        let vm = HomeViewModel(listProductsUseCase: listProductsUseCase,
                               createCartUseCase: createCartUseCase,
                               addToCartUseCase: addToCartUseCase)
        return vm
    }

    /* ViewControllers */

    func buildHomeViewController(_ vm: HomeViewModel) -> HomeViewController {
        let vc = HomeViewController(vm)
        return vc
    }

    func buildProductDetailsViewController(product: Product) -> ProductDetailsViewController {
        let vc = ProductDetailsViewController(product: product)
        return vc
    }

}
