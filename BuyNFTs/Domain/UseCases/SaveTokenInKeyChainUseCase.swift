//
//  SaveTokenInKeyChainUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 04/09/22.
//

import Foundation
import Security

public enum KeyChainError: Error {
    case unsuccessfulSave
    case unsuccessfulRead
}

extension KeyChainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unsuccessfulSave:
            return NSLocalizedString("Error to save token in keychain", comment: "Save Token Error")
        case .unsuccessfulRead:
            return NSLocalizedString("Error to read token in keychain", comment: "Read Token Error")
        }
    }
}

public protocol SaveTokenInKeyChainUseCaseProtocol {
    func execute(userName: String, token: String) throws
}

public class SaveTokenInKeyChainUseCase: SaveTokenInKeyChainUseCaseProtocol {

    public init() { }

    public func execute(userName: String, token: String) throws {
        let keychainItem = [
          kSecValueData: token.data(using: .utf8)!,
          kSecAttrAccount: userName,
          kSecAttrServer: "buynfts.com",
          kSecClass: kSecClassInternetPassword
        ] as CFDictionary

        let status = SecItemAdd(keychainItem, nil)
        guard status == errSecSuccess else {
            throw KeyChainError.unsuccessfulSave
        }
    }
}
