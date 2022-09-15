//
//  ProductRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Infrastructure

protocol ProductRepositoryProtocol {
    func get() async -> Result<[Product], Error>
}

class ProductRepository: ProductRepositoryProtocol {

    private var network: NetworkServiceProtocol
    private var getTokenAuthorization: ReadTokenInKeyChainUseCaseProtocol

    init() {
        self.network = NetworkService()
        self.getTokenAuthorization = ReadTokenInKeyChainUseCase()
    }

    func get() async -> Result<[Product], Error> {
        var token = ""

        do {
            token = try getTokenAuthorization.execute()
        } catch {
            return .failure(error)
        }

        let result = await network.request(path: Router.getProducts.path, httpMethod: Router.getProducts.httpMethod, body: nil, headerAuthorization: token)

        switch result {
        case .success(let data):
            do {
                let parsedData = try JSONDecoder().decode([Product].self, from: data)

                return .success(parsedData)
            } catch {
                fatalError("Json Decoder with Product in getProducts router")
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
