//
//  RemoveToCartUseCaseTests.swift
//  HomeTests
//
//  Created by Gustavo Araujo Santos on 24/11/22.
//

import XCTest
@testable import Home
import Shared

final class RemoveToCartUseCaseTests: XCTestCase {

    private var useCase: RemoveToCartUseCase?
    private var cartRepository = CartRepository()

    private var mockUser = Customer(id: 1, name: "test", token: "token-security", wallet: "xxxx")
    private var mockProducts = [
        Product(id: 1, name: "tst", type: .crypto, price: 100, image: "null", creator: nil, collection: nil, tracker: "tst/usd"),
        Product(id: 2, name: "tst2", type: .crypto, price: 150, image: "null", creator: nil, collection: nil, tracker: "tst2/usd")
    ]
    private var mockShoppingCart: ShoppingCart?

    override func setUp() {
        mockShoppingCart = ShoppingCart(customer: mockUser, products: mockProducts)
        useCase = RemoveToCartUseCase(cartRepository: cartRepository)
    }

    func testExecute() {
        guard
            let mockShoppingCart = mockShoppingCart,
            let product = mockProducts.first,
            let useCase = useCase
        else {
            return XCTFail("nil objects")
        }

        let response = useCase.execute(product: product, cart: mockShoppingCart)

        XCTAssertEqual(response.products.count, 1)
    }

}
