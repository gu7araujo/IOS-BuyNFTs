//
//  LoginUseCaseTests.swift
//  DomainTests
//
//  Created by Gustavo Araujo Santos on 12/09/22.
//

import XCTest
import Domain

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
        let result = await useCase.execute(userName: "test", password: "tst")

        switch result {
        case .failure(let error):
            XCTFail("Expected to be a success but got a failure with \(error)")
        case .success(let value):
            XCTAssertEqual(value, "aaaa-xxxx-bbbb")
        }
    }

    func testExecuteError() async {
        self.useCase = LoginUseCase(useRepository: repositoryMock(returnError: true))
        let result = await useCase.execute(userName: "test", password: "tst")

        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, LoginError.userNotFound.localizedDescription)
        case .success(let value):
            XCTFail("Expected to be a failure but got a success with value: \(value)")
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

    func get(userName: String, password: String) async -> Result<Customer, Error> {
        if isReturnError {
            return .failure(RepositoryError.returnedError)
        } else {
            return .success(customer)
        }
    }

    func getByToken() async -> Result<Customer, Error> {
        fatalError("not used in this case")
    }
}
