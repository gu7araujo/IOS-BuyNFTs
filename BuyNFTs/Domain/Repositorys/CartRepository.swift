//
//  CartRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 08/09/22.
//

import Foundation

protocol CartRepositoryProtocol {
    func get() async -> Result<ShoppingCart, Error>
    func addProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart
    func deleteProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart
}

class CartRepository: CartRepositoryProtocol {

    private var userRepository: UserRepositoryProtocol

    init() {
        self.userRepository = UserRepository()
    }

    func get() async -> Result<ShoppingCart, Error> {
        let userResult = await userRepository.getByToken()

        switch userResult {
        case .success(let customer):
            let cart = ShoppingCart(customer: customer, products: [])
            return .success(cart)
        case .failure(let error):
            return .failure(error)
        }
    }

    func addProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart {
        var newCart = cart
        newCart.products.append(product)
        return newCart
    }

    func deleteProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart {
        var newCart = cart
        guard let index = newCart.products.firstIndex(where: { $0.id == product.id }) else {
            return newCart
        }
        newCart.products.remove(at: index)
        return newCart
    }
}
