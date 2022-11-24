//
//  ProductService.swift
//  Home
//
//  Created by Gustavo Araujo Santos on 23/11/22.
//

import Shared
import Foundation

public protocol ProductServiceProtocol {
    func fetchProducts(token: String) async throws -> [Product]
}

public class ProductService: ProductServiceProtocol {

    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Initialization

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods

    public func fetchProducts(token: String) async throws -> [Product] {
        let response = try await networkService.request(path: Router.getProducts.path, httpMethod: Router.getProducts.httpMethod, body: nil, headerAuthorization: token)

        do {
            let products = try JSONDecoder().decode([Product].self, from: response)
            return products
        } catch {
            fatalError("Json Decoder with Product in getProducts router")
        }
    }

}
