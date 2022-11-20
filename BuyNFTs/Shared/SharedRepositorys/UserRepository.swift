//
//  UserRepository.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 18/11/22.
//

import Foundation

public protocol UserRepositoryProtocol {
    func get(userName: String, password: String) async throws -> Customer
    func getByToken() async throws -> Customer
}

public class UserRepository: UserRepositoryProtocol {

    private var network: NetworkServiceProtocol
    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    public init(network: NetworkServiceProtocol, readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol) {
        self.network = network
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    public func get(userName: String, password: String) async throws -> Customer {
        let body = ["username": userName, "password": password]
        let response = try await network.request(path: Router.doLogin.path, httpMethod: Router.doLogin.httpMethod, body: body, headerAuthorization: nil)

        do {
            let customer = try JSONDecoder().decode(Customer.self, from: response)

            return customer
        } catch {
            fatalError("Json Decoder with Customer in login router")
        }
    }

    public func getByToken() async throws -> Customer {
        let token = try readTokenInKeyChainUseCase.execute()
        let response = try await network.request(path: Router.getUser.path, httpMethod: Router.getUser.httpMethod, body: nil, headerAuthorization: token)

        do {
            let customer = try JSONDecoder().decode(Customer.self, from: response)

            return customer
        } catch {
            fatalError("Json Decoder with Customer in get user router")
        }
    }

}
