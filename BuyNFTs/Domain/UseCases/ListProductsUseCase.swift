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

protocol ListProductsUseCaseProtocol {
    func execute() throws -> [Product]
}

final class ListProductsUseCase: ListProductsUseCaseProtocol {
    init() { }

    func execute() throws -> [Product] {
        // do call to api here

        if false {
            throw ListProductsError.notReturnedProducts
        }

        let product = NFT(id: 0, name: "", price: 0, creator: "", collection: "", image: "")
        let products = [product]

        return products
    }
}
