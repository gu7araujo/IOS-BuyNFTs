//
//  AddToCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
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

public protocol AddToCartUseCaseProtocol {
    func execute(product: Product, cart: ShoppingCart) -> ShoppingCart
}

public class AddToCartUseCase: AddToCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol

    public init() {
        self.cartRepository = CartRepository()
    }

    public func execute(product: Product, cart: ShoppingCart) -> ShoppingCart {
        let newCart = cartRepository.addProduct(cart, product: product)
        return newCart
    }
}
