//
//  Article.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

public struct Article: Decodable {
    public let id: Int
    public let title: String
    public let body: String
}
