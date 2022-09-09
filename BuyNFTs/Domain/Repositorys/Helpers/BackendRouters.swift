//
//  BackendRouters.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Infrastructure

enum Router {
    case doLogin
    case getNFTs
    case getUser

    var path: String {
        switch self {
        case .doLogin:
            return "/login"
        case .getNFTs:
            return "/nft"
        case .getUser:
            return "/login"
        }
    }

    var httpMethod: HTTPMethodType {
        switch self {
        case .doLogin:
            return HTTPMethodType.post
        case .getNFTs:
            return HTTPMethodType.get
        case .getUser:
            return HTTPMethodType.get
        }
    }
}
