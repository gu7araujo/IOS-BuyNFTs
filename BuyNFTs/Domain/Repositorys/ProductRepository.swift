//
//  ProductRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Infrastructure

protocol ProductRepositoryProtocol {
    func get() async -> Result<[NFT], Error>
}

class ProductRepository: ProductRepositoryProtocol {

    private var network: NetworkServiceProtocol
    private var getTokenAuthorization: ReadTokenInKeyChainUseCaseProtocol

    init() {
        self.network = NetworkService()
        self.getTokenAuthorization = ReadTokenInKeyChainUseCase()
    }

    func get() async -> Result<[NFT], Error> {
        var token = ""

        do {
            token = try getTokenAuthorization.execute()
        } catch {
            return .failure(error)
        }

        let result = await network.request(path: Router.getNFTs.path, httpMethod: Router.getNFTs.httpMethod, body: nil, headerAuthorization: token)

        switch result {
        case .success(let data):
            do {
                let parsedData = try JSONDecoder().decode([NFT].self, from: data)

                return .success(parsedData)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
