//
//  UserService.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 23/11/22.
//

import Foundation

public protocol UserServiceProtocol {
    func fetchUser(username: String, password: String) async throws -> Customer
    func fetchUser(by token: String) async throws -> Customer
}

public class UserService: UserServiceProtocol {

    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Initialization

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods

    public func fetchUser(by token: String) async throws -> Customer {
        let response = try await networkService.request(path: Router.getUser.path, httpMethod: Router.getUser.httpMethod, body: nil, headerAuthorization: token)

        do {
            let customer = try JSONDecoder().decode(Customer.self, from: response)
            return customer
        } catch {
            fatalError("Json Decoder with Customer in get user router")
        }
    }

    public func fetchUser(username: String, password: String) async throws -> Customer {
        let body = ["username": username, "password": password]
        let response = try await networkService.request(path: Router.doLogin.path, httpMethod: Router.doLogin.httpMethod, body: body, headerAuthorization: nil)

        do {
            let customer = try JSONDecoder().decode(Customer.self, from: response)
            return customer
        } catch {
            fatalError("Json Decoder with Customer in login router")
        }
    }

}
