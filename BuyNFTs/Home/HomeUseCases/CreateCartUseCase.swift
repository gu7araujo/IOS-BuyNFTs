//
//  CreateCartUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 12/09/22.
//

import Foundation
import Shared

protocol CreateCartUseCaseProtocol {
    func execute() async throws -> ShoppingCart
}

class CreateCartUseCase: CreateCartUseCaseProtocol {

    private var cartRepository: CartRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    init(cartRepository: CartRepositoryProtocol, userRepository: UserRepositoryProtocol, readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol) {
        self.cartRepository = cartRepository
        self.userRepository = userRepository
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    public func execute() async throws -> ShoppingCart {
        let token = try readTokenInKeyChainUseCase.execute()
        let user = try await userRepository.getUser(by: token)
        let result = try await cartRepository.createCart(by: user)
        return result
    }

}
