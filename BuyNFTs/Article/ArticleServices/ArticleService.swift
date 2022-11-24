//
//  ArticleService.swift
//  Article
//
//  Created by Gustavo Araujo Santos on 23/11/22.
//

import Foundation
import Shared

public protocol ArticleServiceProtocol {
    func fetchArticles(token: String) async throws -> [Article]
}

public class ArticleService: ArticleServiceProtocol {

    // MARK: - Properties

    private let networkService: NetworkServiceProtocol

    // MARK: - Initialization

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    // MARK: - Methods

    public func fetchArticles(token: String) async throws -> [Article] {
        let response = try await networkService.request(path: Router.getArticles.path, httpMethod: Router.getArticles.httpMethod, body: nil, headerAuthorization: token)

        do {
            let articlesResult = try JSONDecoder().decode([Article].self, from: response)
            return articlesResult
        } catch {
            fatalError("Json Decoder with Article in getArticles router")
        }
    }

}
