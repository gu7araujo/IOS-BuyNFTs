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
}

class UserRepository: UserRepositoryProtocol {

    private var network: NetworkServiceProtocol

    init() {
        self.network = NetworkService()
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
}
