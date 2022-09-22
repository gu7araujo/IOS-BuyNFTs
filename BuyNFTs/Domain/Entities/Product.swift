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

    public func getProductTitle() -> String {
        switch type {
        case .crypto:
            guard let tracker = tracker else { fatalError("Attribute tracker should get from API") }
            return tracker
        case .nft:
            guard let collection = collection, let creator = creator else {
                fatalError("Attributes collection, creator should get from API")
            }
            return "\(collection) - \(self.name) - \(creator)"
        }
    }

    public func getProductPrice() -> String {
        switch type {
        case .crypto:
            return String(self.price) + " USD"
        case .nft:
            return String(self.price) + " ETH"
        }
    }
}
