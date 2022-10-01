//
//  ExistsTokenInKeyChainUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 01/10/22.
//

import Security

public protocol ExistsTokenInKeyChainUseCaseProtocol {
    func execute() throws
}

public class ExistsTokenInKeyChainUseCase: ExistsTokenInKeyChainUseCaseProtocol {

    public init() { }

    public func execute() throws {
        let query = [
          kSecClass: kSecClassInternetPassword,
          kSecAttrServer: "buynfts.com",
          kSecReturnAttributes: true,
          kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        guard status == errSecSuccess else {
            throw KeyChainError.unsuccessfulRead
        }
    }
}
