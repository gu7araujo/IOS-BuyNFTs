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
            let result = await listArticlesUseCase.execute()
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }

}
