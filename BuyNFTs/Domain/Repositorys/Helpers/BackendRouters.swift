//
//  BackendRouters.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import Infrastructure

enum Router {
    case doLogin
    case getProducts
    case getUser
    case getArticles

    var path: String {
        switch self {
        case .doLogin:
            return "/login"
        case .getProducts:
            return "/products"
        case .getUser:
            return "/login"
        case .getArticles:
            return "/articles"
        }
    }

    var httpMethod: HTTPMethodType {
        switch self {
        case .doLogin:
            return HTTPMethodType.post
        case .getProducts:
            return HTTPMethodType.get
        case .getUser:
            return HTTPMethodType.get
        case .getArticles:
            return HTTPMethodType.get
        }
    }
}
