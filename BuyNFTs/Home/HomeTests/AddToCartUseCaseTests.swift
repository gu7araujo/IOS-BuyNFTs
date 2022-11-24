//
//  AddToCartUseCaseTests.swift
//  HomeTests
//
//  Created by Gustavo Araujo Santos on 24/11/22.
//

import XCTest
@testable import Home
import Shared

final class AddToCartUseCaseTests: XCTestCase {

    private var useCase: AddToCartUseCase?
    private var cartRepository = CartRepository()

    private var mockUser = Customer(id: 1, name: "test", token: "token-security", wallet: "xxxx")
    private var mockProduct = Product(id: 1, name: "tst", type: .crypto, price: 100, image: "null", creator: nil, collection: nil, tracker: "tst/usd")
    private var mockShoppingCart: ShoppingCart?

    override func setUp() {
        mockShoppingCart = ShoppingCart(customer: mockUser, products: [])
        useCase = AddToCartUseCase(cartRepository: cartRepository)
    }

    func testExecute() {
        guard
            let mockShoppingCart = mockShoppingCart,
            let useCase = useCase
        else {
            return XCTFail("nil objects")
        }

        let response = useCase.execute(product: mockProduct, cart: mockShoppingCart)

        XCTAssertEqual(response.products.count, 1)
    }

}
