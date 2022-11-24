//
//  UserRepository.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 18/11/22.
//

import Foundation

public protocol UserRepositoryProtocol {
    func getUser(username: String, password: String) async throws -> Customer
    func getUser(by token: String) async throws -> Customer
}

public class UserRepository: UserRepositoryProtocol {

    private let userService: UserServiceProtocol

    public init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    public func getUser(username: String, password: String) async throws -> Customer {
        let response = try await userService.fetchUser(username: username, password: password)
        return response
    }

    public func getUser(by token: String) async throws -> Customer {
        let response = try await userService.fetchUser(by: token)
        return response
    }

}
