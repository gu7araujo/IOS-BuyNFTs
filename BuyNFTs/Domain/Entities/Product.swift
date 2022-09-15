//
//  Product.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

public enum ProductTypes: Decodable {
    case crypto
    case nft

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let types = try? container.decode(String.self)
        switch types {
        case "crypto": self = .crypto
        case "nft": self = .nft
        default:
            fatalError("The type returned of the API is wrong")
        }
    }
}

public struct Product: Decodable {
    public let id: Int
    public let name: String
    public let type: ProductTypes
    public let price: Double
    public let image: String
    public let creator: String?
    public let collection: String?
    public let tracker: String?
}
