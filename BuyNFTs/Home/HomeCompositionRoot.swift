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

    /* Services */

    func buildProductService() -> ProductServiceProtocol {
        let networkService = SharedCompositionRoot.shared.buildNetworkService()
        let service = ProductService(networkService: networkService)
        return service
    }

    /* Repositorys */

    func buildCartRepository() -> CartRepositoryProtocol {
        let repository = CartRepository()
        return repository
    }

    func buildProductRepository() -> ProductRepositoryProtocol {
        let productService = buildProductService()
        let repository = ProductRepository(productService: productService)
        return repository
    }

    /* UseCases */

    func buildAddToCartUseCase() -> AddToCartUseCaseProtocol {
        let cartRepository = buildCartRepository()
        let useCase = AddToCartUseCase(cartRepository: cartRepository)
        return useCase
    }

    func buildCreateCartUseCase() -> CreateCartUseCaseProtocol {
        let readTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildReadTokenInKeyChainUseCase()
        let userRepository = SharedCompositionRoot.shared.buildUserRepository()
        let cartRepository = buildCartRepository()
        let useCase = CreateCartUseCase(cartRepository: cartRepository, userRepository: userRepository, readTokenInKeyChainUseCase: readTokenInKeyChainUseCase)
        return useCase
    }

    func buildListProductsUseCase() -> ListProductsUseCaseProtocol {
        let readTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildReadTokenInKeyChainUseCase()
        let productRepository = buildProductRepository()
        let useCase = ListProductsUseCase(productRepository: productRepository,
                                          readTokenInKeyChainUseCase: readTokenInKeyChainUseCase)
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
