//
//  UserRepository.swift
//  Data
//
//  Created by Gustavo Araujo Santos on 11/08/22.
//

import Foundation
import Infrastructure

protocol UserRepositoryProtocol {
    func get(userName: String, password: String) async -> Result<Customer, Error>
    func getByToken() async -> Result<Customer, Error>
}

class UserRepository: UserRepositoryProtocol {

    private var network: NetworkServiceProtocol
    private var getTokenAuthorization: ReadTokenInKeyChainUseCaseProtocol

    init() {
        self.network = NetworkService()
        self.getTokenAuthorization = ReadTokenInKeyChainUseCase()
    }

    func get(userName: String, password: String) async -> Result<Customer, Error> {
        let body = ["username": userName, "password": password]
        let result = await network.request(path: Router.doLogin.path, httpMethod: Router.doLogin.httpMethod, body: body, headerAuthorization: nil)

        switch result {
        case .success(let data):
            do {
                let parsedData = try JSONDecoder().decode(Customer.self, from: data)

                return .success(parsedData)
            } catch {
                fatalError("Json Decoder with Customer in login router")
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    func getByToken() async -> Result<Customer, Error> {
        var token = ""

        do {
            token = try getTokenAuthorization.execute()
        } catch {
            return .failure(error)
        }

        let result = await network.request(path: Router.getUser.path, httpMethod: Router.getUser.httpMethod, body: nil, headerAuthorization: token)

        switch result {
        case .success(let data):
            do {
                let parsedData = try JSONDecoder().decode(Customer.self, from: data)

                return .success(parsedData)
            } catch {
                fatalError("Json Decoder with Customer in get user router")
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
