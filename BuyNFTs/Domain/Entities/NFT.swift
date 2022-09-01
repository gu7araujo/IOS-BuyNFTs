//
//  NFT.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 28/07/22.
//

public struct NFT: Product {
    public let id: Int
    public let name: String
    public let price: Double
    public let creator: String
    public let collection: String
    public let image: String

    public init(id: Int,
                name: String,
                price: Double,
                creator: String,
                collection: String,
                image: String) {
        self.id = id
        self.name = name
        self.price = price
        self.creator = creator
        self.collection = collection
        self.image = image
    }
}
