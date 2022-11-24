//
//  ListArticlesUseCase.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation
import Shared

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

    private let articleRepository: ArticleRepositoryProtocol
    private let readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    init(articleRepository: ArticleRepositoryProtocol, readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol) {
        self.articleRepository = articleRepository
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    func execute() async throws -> [Article] {
        do {
            let token = try readTokenInKeyChainUseCase.execute()
            let response = try await articleRepository.getArticles(token: token)
            return response
        } catch {
            throw ListArticlesError.notReturnedArticles
        }
    }

}
