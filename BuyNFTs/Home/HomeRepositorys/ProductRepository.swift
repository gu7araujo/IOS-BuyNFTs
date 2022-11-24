//
//  ProductRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Shared

protocol ProductRepositoryProtocol {
    func getProducts(token: String) async throws -> [Product]
}

class ProductRepository: ProductRepositoryProtocol {

    private let productService: ProductServiceProtocol

    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }

    func getProducts(token: String) async throws -> [Product] {
        let response = try await productService.fetchProducts(token: token)
        return response
    }

}
