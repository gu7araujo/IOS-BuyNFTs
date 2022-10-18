//
//  CreateCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 12/09/22.
//

import Foundation

public protocol CreateCartUseCaseProtocol {
    func execute() async throws -> ShoppingCart
}

public class CreateCartUseCase: CreateCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol

    public init() {
        self.cartRepository = CartRepository()
    }

    public func execute() async throws -> ShoppingCart {
        let shoopingCartResult = try await cartRepository.get()
        return shoopingCartResult
    }
}
