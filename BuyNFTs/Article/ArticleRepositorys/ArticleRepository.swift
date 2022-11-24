//
//  ArticleRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation
import Shared

public protocol ArticleRepositoryProtocol {
    func getArticles(token: String) async throws -> [Article]
}

public class ArticleRepository: ArticleRepositoryProtocol {

    private let articleService: ArticleServiceProtocol

    public init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }

    public func getArticles(token: String) async throws -> [Article] {
        let response = try await articleService.fetchArticles(token: token)
        return response
    }

}
