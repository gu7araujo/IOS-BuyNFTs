//
//  AddToCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Domain

enum AddToCartError: Error {
    case notAdded
}

protocol AddToCartUseCaseProtocol {
    func execute(product: Product, cart: ShoppingCart) throws -> ShoppingCart
}

final class AddToCartUseCase: AddToCartUseCaseProtocol {
    init() { }

    func execute(product: Product, cart: ShoppingCart) throws -> ShoppingCart {
        // do api call here

        if true {
            throw AddToCartError.notAdded
        }

        var newCart = cart
//        newCart.products.append(product)

        return newCart
    }
}