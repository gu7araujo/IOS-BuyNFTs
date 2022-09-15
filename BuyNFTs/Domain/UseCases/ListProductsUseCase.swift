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

public protocol ListProductsUseCaseProtocol {
    func execute() async -> Result<[Product], Error>
}

public class ListProductsUseCase: ListProductsUseCaseProtocol {

    private var productRepository: ProductRepositoryProtocol

    public init() {
        self.productRepository = ProductRepository()
    }

    public func execute() async -> Result<[Product], Error> {
        let result = await productRepository.get()

        switch result {
        case .success(let products):
            return .success(products)
        case .failure(_):
            return .failure(ListProductsError.notReturnedProducts)
        }
    }
}
