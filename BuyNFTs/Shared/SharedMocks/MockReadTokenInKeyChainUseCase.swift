//
//  MockReadTokenInKeyChainUseCase.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 24/11/22.
//

public class MockReadTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol {
    public init() { }

    public func execute() throws -> String {
        "token-security"
    }
}
