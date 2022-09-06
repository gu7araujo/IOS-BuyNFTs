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
        // refatorar a criacao do body
        // refatorar o parse da response
        // criar e lidar com os erros
        // extrair Router
        let result = await network.request(path: Router.doLogin.path, httpMethod: Router.doLogin.httpMethod, body: ["username": userName, "password": password], headerAuthorization: nil)

        switch result {
        case .success(let data):
            do {
                let parsedData = try JSONDecoder().decode(Customer.self, from: data)

                return .success(parsedData)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

enum Router {
    case doLogin
    case getNFTs

    var path: String {
        switch self {
        case .doLogin:
            return "/login"
        case .getNFTs:
            return "/nft"
        }
    }

    var httpMethod: HTTPMethodType {
        switch self {
        case .doLogin:
            return HTTPMethodType.post
        case .getNFTs:
            return HTTPMethodType.get
        }
    }
}
