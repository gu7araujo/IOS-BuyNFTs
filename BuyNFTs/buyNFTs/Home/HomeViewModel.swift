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
    func addToShoopingCart(product: Product)
    func openProductDetails(_ product: Product)
}

class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Public properties

    @Published var error: String?
    var errorPublished: Published<String?> { _error }
    var errorPublisher: Published<String?>.Publisher { $error }

    @Published var products: [Product] = []
    var productsPublished: Published<[Product]> { _products }
    var productsPublisher: Published<[Product]>.Publisher { $products }

    @Published var cart: ShoppingCart?
    var cartPublished: Published<ShoppingCart?> { _cart }
    var cartPublisher: Published<ShoppingCart?>.Publisher { $cart }

    var didSendEventClosure: ((HomeViewModel.Event) -> Void)?

    // MARK: - Private properties

    private let listProductsUseCase: ListProductsUseCaseProtocol
    private let createCartUseCase: CreateCartUseCaseProtocol
    private var addToCartUseCase: AddToCartUseCaseProtocol

    // MARK: - Initialization

    init(listProductsUseCase: ListProductsUseCaseProtocol = ListProductsUseCase(), createCartUseCase: CreateCartUseCaseProtocol = CreateCartUseCase(), addToCartUseCase: AddToCartUseCaseProtocol = AddToCartUseCase()) {
        self.listProductsUseCase = listProductsUseCase
        self.createCartUseCase = createCartUseCase
        self.addToCartUseCase = addToCartUseCase
    }

    // MARK: - Methods

    func openProductDetails(_ product: Product) {
        guard let didSendEventClosure = self.didSendEventClosure else { fatalError("Closure didn't set") }
        didSendEventClosure(.openDetails(product))
    }

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
