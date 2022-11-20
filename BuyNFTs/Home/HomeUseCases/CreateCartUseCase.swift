//
//  CreateCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 12/09/22.
//

import Foundation

protocol CreateCartUseCaseProtocol {
    func execute() async throws -> ShoppingCart
}

class CreateCartUseCase: CreateCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol

    init(cartRepository: CartRepositoryProtocol) {
        self.cartRepository = cartRepository
    }

    public func execute() async throws -> ShoppingCart {
        let shoopingCartResult = try await cartRepository.get()
        return shoopingCartResult
    }
}
