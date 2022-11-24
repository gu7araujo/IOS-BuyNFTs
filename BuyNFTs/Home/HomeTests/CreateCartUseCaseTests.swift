//
//  CreateCartUseCaseTests.swift
//  HomeTests
//
//  Created by Gustavo Araujo Santos on 23/11/22.
//

import XCTest
@testable import Home
import Shared

final class CreateCartUseCaseTests: XCTestCase {

    private var useCase: CreateCartUseCase?
    private var cartRepository = CartRepository()
    private var mockUser = Customer(id: 1, name: "test", token: "token-security", wallet: "xxxx")

    override func setUp() {
        let mockReadTokenUseCase = MockReadTokenInKeyChainUseCase()
        let mockUserRepository = MockUserRepository(user: mockUser)
        useCase = CreateCartUseCase(cartRepository: cartRepository,
                                    userRepository: mockUserRepository,
                                    readTokenInKeyChainUseCase: mockReadTokenUseCase)
    }

    func testExecute() async {
        do {
            let response = try await useCase?.execute()

            guard let response = response else {
                XCTFail("nil object")
                return
            }

            XCTAssertEqual(response.customer.name, mockUser.name)
            XCTAssertTrue(response.products.isEmpty)
        } catch {
            XCTFail("Expected to be a success but got a failure with \(error)")
        }
    }

}

class MockUserRepository: UserRepositoryProtocol {

    private let user: Customer

    init(user: Customer) {
        self.user = user
    }

    func getUser(username: String, password: String) async throws -> Shared.Customer {
        fatalError("Didn't used here")
    }

    func getUser(by token: String) async throws -> Shared.Customer {
        return user
    }
}
