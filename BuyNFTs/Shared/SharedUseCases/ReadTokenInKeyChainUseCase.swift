//
//  ReadTokenInKeyChain.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 04/09/22.
//

import Foundation
import Security

public protocol ReadTokenInKeyChainUseCaseProtocol {
    func execute() throws -> String
}

public class ReadTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol {

    public init() { }

    public func execute() throws -> String {
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

        let dic = result as! NSDictionary
        let passwordData = dic[kSecValueData] as! Data
        return String(data: passwordData, encoding: .utf8)!
    }

}
