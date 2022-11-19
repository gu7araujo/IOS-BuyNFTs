//
//  ProductRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Shared

protocol ProductRepositoryProtocol {
    func get() async throws -> [Product]
}

class ProductRepository: ProductRepositoryProtocol {

    private var network: NetworkServiceProtocol
    private var getTokenAuthorization: ReadTokenInKeyChainUseCaseProtocol

    init() {
        self.network = NetworkService()
        self.getTokenAuthorization = ReadTokenInKeyChainUseCase()
    }

    func get() async throws -> [Product] {
        let tokenResult = try getTokenAuthorization.execute()
        let response = try await network.request(path: Router.getProducts.path, httpMethod: Router.getProducts.httpMethod, body: nil, headerAuthorization: tokenResult)

        do {
            let products = try JSONDecoder().decode([Product].self, from: response)
            return products
        } catch {
            fatalError("Json Decoder with Product in getProducts router")
        }
    }
}
