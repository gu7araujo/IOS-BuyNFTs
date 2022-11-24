//
//  CartRepository.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 14/11/22.
//

import Foundation
import Shared

protocol CartRepositoryProtocol {
    func createCart(by customer: Customer) async throws -> ShoppingCart
    func addProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart
    func deleteProduct(_ cart: ShoppingCart, product: Product) -> ShoppingCart
}

class CartRepository: CartRepositoryProtocol {

    init() { }

    func createCart(by customer: Customer) async throws -> ShoppingCart {
        return ShoppingCart(customer: customer, products: [])
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
