//
//  ListProductsUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 29/07/22.
//

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

    private var productRepository: ProductRepositoryProtocol

    init(productRepository: ProductRepositoryProtocol) {
        self.productRepository = productRepository
    }

    func execute() async throws -> [Product] {
        do {
            let productsResult = try await productRepository.get()
            return productsResult
        } catch {
            throw ListProductsError.notReturnedProducts
        }
    }
}
