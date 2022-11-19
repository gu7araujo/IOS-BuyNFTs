//
//  RemoveToCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 12/09/22.
//

import Foundation

protocol RemoveToCartUseCaseProtocol {
    func execute(product: Product, cart: ShoppingCart) -> ShoppingCart
}

class RemoveToCartUseCase: RemoveToCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol

    init() {
        self.cartRepository = CartRepository()
    }

    func execute(product: Product, cart: ShoppingCart) -> ShoppingCart {
        let newCart = cartRepository.deleteProduct(cart, product: product)
        return newCart
    }
}
