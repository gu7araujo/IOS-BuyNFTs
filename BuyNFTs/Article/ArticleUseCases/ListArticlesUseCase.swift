//
//  ListArticlesUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation

enum ListArticlesError: Error {
    case notReturnedArticles
}

extension ListArticlesError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notReturnedArticles:
            return NSLocalizedString("The articles were not returned", comment: "List Articles Error")
        }
    }
}

protocol ListArticlesUseCaseProtocol {
    func execute() async throws -> [Article]
}

class ListArticlesUseCase: ListArticlesUseCaseProtocol {

    private var articleRepository: ArticleRepositoryProtocol

    init(articleRepository: ArticleRepositoryProtocol) {
        self.articleRepository = articleRepository
    }

    func execute() async throws -> [Article] {
        do {
            let articlesResponse = try await articleRepository.get()
            return articlesResponse
        } catch {
            throw ListArticlesError.notReturnedArticles
        }
    }

}
