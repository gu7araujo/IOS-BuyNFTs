//
//  Product.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

import Foundation

protocol Product {
    var id: Int { get }
    var name: String { get }
    var price: Double { get }
}
