//
//  HomeViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation

class HomeViewModel {

    // MARK: - Public properties

    @Published var error: String?
    @Published var products: [Product] = []
    @Published var cart: ShoppingCart?

    // MARK: - Private properties

    private let listProductsUseCase: ListProductsUseCaseProtocol
    private let createCartUseCase: CreateCartUseCaseProtocol
    private var addToCartUseCase: AddToCartUseCaseProtocol

    // MARK: - Initialization

    init(listProductsUseCase: ListProductsUseCaseProtocol,
         createCartUseCase: CreateCartUseCaseProtocol,
         addToCartUseCase: AddToCartUseCaseProtocol)
    {
        self.listProductsUseCase = listProductsUseCase
        self.createCartUseCase = createCartUseCase
        self.addToCartUseCase = addToCartUseCase
    }

    // MARK: - Methods

    func addToShoopingCart(product: Product) {
        guard let cart = self.cart else { return }
        guard !cart.products.contains(where: { $0.id == product.id }) else { return }

        let newCart = addToCartUseCase.execute(product: product, cart: cart)
        self.cart = newCart
    }

    func createShoopingCart() {
        Task {
            do {
                let shoopingCartResult = try await createCartUseCase.execute()
                self.cart = shoopingCartResult
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

    func getProducts() {
        Task {
            do {
                let productsResult = try await listProductsUseCase.execute()
                self.products = productsResult
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

}

extension HomeViewModel {
    enum Event {
        case openDetails(_ product: Product)
    }
}
