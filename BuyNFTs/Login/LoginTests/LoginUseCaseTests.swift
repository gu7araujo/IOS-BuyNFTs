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

    private var useCase: LoginUseCaseProtocol!

    // MARK: - Mock dependencies

    var userRepository: UserRepositoryProtocol = repositoryMock()

    // MARK: - Life cycle

    override func setUp() {
        useCase = LoginUseCase(useRepository: userRepository)
    }

    // MARK: - Tests

    func testExecute() async {
        do {
            let result = try await useCase.execute(userName: "test", password: "tst")
            XCTAssertEqual(result, "aaaa-xxxx-bbbb")
        } catch {
            XCTFail("Expected to be a success but got a failure with \(error)")
        }
    }

    func testExecuteError() async {
        self.useCase = LoginUseCase(useRepository: repositoryMock(returnError: true))

        do {
            let result = try await useCase.execute(userName: "test", password: "tst")
            XCTFail("Expected to be a failure but got a success with value: \(result)")
        } catch {
            XCTAssertEqual(error.localizedDescription, LoginError.userNotFound.localizedDescription)
        }
    }
}

class repositoryMock: UserRepositoryProtocol {

    var isReturnError: Bool
    var customer = Customer(id: 5, name: "Sr Test", token: "aaaa-xxxx-bbbb", wallet: "42ssss.ppppppp")

    init(returnError: Bool = false) {
        self.isReturnError = returnError
    }

    enum RepositoryError: Error {
        case returnedError
    }

    func get(userName: String, password: String) async throws -> Customer {
        if isReturnError {
            throw RepositoryError.returnedError
        } else {
            return customer
        }
    }

    func getByToken() async throws -> Customer {
        fatalError("not used in this case")
    }
}
