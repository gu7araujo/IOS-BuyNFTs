//
//  LoginUseCaseTests.swift
//  LoginTests
//
//  Created by Gustavo Araujo Santos on 14/11/22.
//

import XCTest
import Shared
@testable import Login

class LoginUseCaseTests: XCTestCase {

    private var useCase: LoginUseCaseProtocol?
    private var mockCustomer = Customer(id: 5, name: "Sr Test", token: "aaaa-xxxx-bbbb", wallet: "42ssss.ppppppp")

    override func setUp() {
        let mockUserRepository = MockUserRepository(customerReturn: mockCustomer)
        useCase = LoginUseCase(useRepository: mockUserRepository)
    }

    func testExecute() async {
        do {
            let result = try await useCase?.execute(userName: "tst", password: "tst")

            XCTAssertEqual(result, mockCustomer.token)
        } catch {
            XCTFail("Expected to be a success but got a failure with \(error)")
        }
    }

    func testExecuteError() async {
        let mockRepository = MockUserRepository(returnError: true, customerReturn: mockCustomer)
        useCase = LoginUseCase(useRepository: mockRepository)

        do {
            let result = try await useCase?.execute(userName: "tst", password: "tsts")
            XCTFail("Expected to be a failure but got a success with value: \(result)")
        } catch {
            XCTAssertEqual(error.localizedDescription, LoginError.userNotFound.localizedDescription)
        }
    }

}

class MockUserRepository: UserRepositoryProtocol {

    var isReturnError: Bool
    var customer: Customer

    init(returnError: Bool = false, customerReturn: Customer) {
        self.isReturnError = returnError
        self.customer = customerReturn
    }

    enum RepositoryError: Error {
        case returnedError
    }

    func getUser(username: String, password: String) async throws -> Shared.Customer {
        if isReturnError {
            throw RepositoryError.returnedError
        } else {
            return customer
        }
    }

    func getUser(by token: String) async throws -> Shared.Customer {
        if isReturnError {
            throw RepositoryError.returnedError
        } else {
            return customer
        }
    }

}
