//
//  HomeViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Foundation
import Domain

protocol HomeViewModelProtocol {
    var errorPublished: Published<String?> { get }
    var errorPublisher: Published<String?>.Publisher { get }
    func getProducts()
}

class HomeViewModel: HomeViewModelProtocol {

    @Published var error: String?
    var errorPublished: Published<String?> { _error }
    var errorPublisher: Published<String?>.Publisher { $error }

    @Published var products: [NFT] = []

    private let getProductsUseCase: ListProductsUseCaseProtocol

    init() {
        self.getProductsUseCase = ListProductsUseCase()
    }

    func getProducts() {
        Task {
            let result = await getProductsUseCase.execute()

            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
