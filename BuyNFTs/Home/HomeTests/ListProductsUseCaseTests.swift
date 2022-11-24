//
//  ListProductsUseCaseTests.swift
//  HomeTests
//
//  Created by Gustavo Araujo Santos on 24/11/22.
//

import XCTest
@testable import Home
import Shared

final class ListProductsUseCaseTests: XCTestCase {

    private var useCase: ListProductsUseCase?
    private let mockReadTokenUseCase = MockReadTokenInKeyChainUseCase()
    private let mockProductRepository = MockProductRepository()

    override func setUp() {
        useCase = ListProductsUseCase(productRepository: mockProductRepository,
                                      readTokenInKeyChainUseCase: mockReadTokenUseCase)
    }

    func testExecute() async {
        guard let useCase = useCase else {
            return XCTFail("nil object")
        }

        do {
            let response = try await useCase.execute()

            XCTAssertEqual(response.count, 3)
        } catch {
            XCTFail("Returned failed")
        }
    }
    
}

class MockProductRepository: ProductRepositoryProtocol {
    let products = [
        Product(id: 1, name: "tst", type: .crypto, price: 100, image: "null", creator: nil, collection: nil, tracker: "tst/usd"),
        Product(id: 2, name: "tst2", type: .crypto, price: 120, image: "null", creator: nil, collection: nil, tracker: "tst2/usd"),
        Product(id: 3, name: "kong", type: .nft, price: 1000, image: "null", creator: "me", collection: "you", tracker: "nil")
    ]

    func getProducts(token: String) async throws -> [Home.Product] {
        return products
    }
}

