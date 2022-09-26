//
//  HomeViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Domain

protocol HomeViewModelProtocol {
    var error: String? { get }
    var errorPublished: Published<String?> { get }
    var errorPublisher: Published<String?>.Publisher { get }
    var products: [Product] { get }
    var productsPublished: Published<[Product]> { get }
    var productsPublisher: Published<[Product]>.Publisher { get }
    var cart: ShoppingCart? { get }
    var cartPublished: Published<ShoppingCart?> { get }
    var cartPublisher: Published<ShoppingCart?>.Publisher { get }
    func getProducts()
    func createShoopingCart()
    func addProductToShoopingCart(_ product: Product?)
    func openProductDetails(_ product: Product?)
}

class HomeViewModel: HomeViewModelProtocol {

    @Published var error: String?
    var errorPublished: Published<String?> { _error }
    var errorPublisher: Published<String?>.Publisher { $error }

    @Published var products: [Product] = []
    var productsPublished: Published<[Product]> { _products }
    var productsPublisher: Published<[Product]>.Publisher { $products }

    @Published var cart: ShoppingCart?
    var cartPublished: Published<ShoppingCart?> { _cart }
    var cartPublisher: Published<ShoppingCart?>.Publisher { $cart }

    private let getProductsUseCase: ListProductsUseCaseProtocol
    private let createShoopingCartUseCase: CreateCartUseCaseProtocol
    private var addProductToShoopingCartUseCase: AddToCartUseCaseProtocol

    var didSendEventClosure: ((HomeViewModel.Event) -> Void)?

    init() {
        self.getProductsUseCase = ListProductsUseCase()
        self.createShoopingCartUseCase = CreateCartUseCase()
        self.addProductToShoopingCartUseCase = AddToCartUseCase()
    }

    func openProductDetails(_ product: Product?) {
        guard let product = product else {
            return
        }

        didSendEventClosure?(.openDetails(product))
    }

    func addProductToShoopingCart(_ product: Product?) {
        guard let cart = self.cart, let product = product else {
            return
        }

        guard !cart.products.contains(where: { $0.id == product.id }) else {
            return
        }

        let newCart = addProductToShoopingCartUseCase.execute(product: product, cart: cart)
        self.cart = newCart
    }

    func createShoopingCart() {
        Task {
            let result = await createShoopingCartUseCase.execute()

            switch result {
            case .success(let cart):
                self.cart = cart
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }

    func getProducts() {
        Task {
            let result = await getProductsUseCase.execute()

            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
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
