//
//  ShoppingCart.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

import Foundation

protocol ShoppingCartProtocol {
    var id: Int { get }
    var customer: Customer { get }
    var products: [Product] { get }
    var totalValue: Double { get }
}

struct ShoppingCart: ShoppingCartProtocol {
    let id: Int
    let customer: Customer
    var products: [Product]
    var totalValue: Double {
        get {
            var value = 0.0
            for product in products {
                value = value + product.price
            }
            return value
        }
    }
}
