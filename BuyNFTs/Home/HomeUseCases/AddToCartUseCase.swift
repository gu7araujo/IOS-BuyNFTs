//
//  AddToCartUseCase.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 14/11/22.
//

import Foundation

enum ShoopingCartError: Error {
    case notAdded
    case notRemoved
}

extension ShoopingCartError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notAdded:
            return NSLocalizedString("The products won't be added on the shooping cart", comment: "Add product for the Cart Error")
        case .notRemoved:
            return NSLocalizedString("The products won't be removed on the shooping cart", comment: "Remove product for the Cart Error")
        }
    }
}

protocol AddToCartUseCaseProtocol {
    func execute(product: Product, cart: ShoppingCart) -> ShoppingCart
}

class AddToCartUseCase: AddToCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol

    init(cartRepository: CartRepositoryProtocol) {
        self.cartRepository = cartRepository
    }

    func execute(product: Product, cart: ShoppingCart) -> ShoppingCart {
        let newCart = cartRepository.addProduct(cart, product: product)
        return newCart
    }
}
