//
//  ListProductsUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

import Shared
import Foundation

enum ListProductsError: Error {
    case notReturnedProducts
}

extension ListProductsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notReturnedProducts:
            return NSLocalizedString("The products were not returned", comment: "List Products Error")
        }
    }
}

protocol ListProductsUseCaseProtocol {
    func execute() async throws -> [Product]
}

class ListProductsUseCase: ListProductsUseCaseProtocol {

    private let productRepository: ProductRepositoryProtocol
    private let readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    init(productRepository: ProductRepositoryProtocol, readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol) {
        self.productRepository = productRepository
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    func execute() async throws -> [Product] {
        do {
            let token = try readTokenInKeyChainUseCase.execute()
            let response = try await productRepository.getProducts(token: token)
            return response
        } catch {
            throw ListProductsError.notReturnedProducts
        }
    }

}
