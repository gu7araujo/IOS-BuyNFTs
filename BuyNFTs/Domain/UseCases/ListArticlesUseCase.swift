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

public protocol ListArticlesUseCaseProtocol {
    func execute() async -> Result<[Article], Error>
}

public class ListArticlesUseCase: ListArticlesUseCaseProtocol {

    private var articleRepository: ArticleRepositoryProtocol

    public init(articleRepository: ArticleRepositoryProtocol = ArticleRepository()) {
        self.articleRepository = articleRepository
    }

    public func execute() async -> Result<[Article], Error> {
        let result = await articleRepository.get()
        switch result {
        case .success(let articles):
            return .success(articles)
        case .failure(_):
            return .failure(ListArticlesError.notReturnedArticles)
        }
    }

}
