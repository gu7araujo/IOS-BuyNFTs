//
//  ShoppingCart.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

import Foundation
import Shared

public protocol ShoppingCartProtocol {
    var id: UUID { get }
    var customer: Customer { get }
    var products: [Product] { get }
    var totalValue: Double { get }
}

public struct ShoppingCart: ShoppingCartProtocol {
    public let id = UUID()
    public let customer: Customer
    public var products: [Product]
    public var totalValue: Double {
        get {
            var value = 0.0
            for product in products {
                value = value + product.price
            }
            return value
        }
    }
}
