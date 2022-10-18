//
//  ArticleViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation
import Domain

class ArticleViewModel {

    // MARK: - Public properties

    var articles: [Article] = []
    var error: String?

    // MARK: - Private properties

    private var listArticlesUseCase: ListArticlesUseCaseProtocol

    // MARK: - Initialization

    init(listArticlesUseCase: ListArticlesUseCaseProtocol = ListArticlesUseCase()) {
        self.listArticlesUseCase = listArticlesUseCase
    }

    deinit {
        print("ArticleViewModel deinit")
    }

    // MARK: - Methods

    func getArticles() {
        Task {
            do {
                let articlesResult = try await listArticlesUseCase.execute()
                self.articles = articlesResult
            } catch {
                self.error = error.localizedDescription
            }
        }
    }

}
