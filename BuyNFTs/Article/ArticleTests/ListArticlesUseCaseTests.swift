//
//  ListArticlesUseCaseTests.swift
//  ArticleTests
//
//  Created by Gustavo Araujo Santos on 24/11/22.
//

import XCTest
@testable import Article
import Shared

final class ListArticlesUseCaseTests: XCTestCase {

    private var useCase: ListArticlesUseCase?
    private let mockArticleRepository = MockArticleRepository()
    private let mockReadTokenInKeyChainUseCase = MockReadTokenInKeyChainUseCase()

    override func setUp() {
        useCase = ListArticlesUseCase(articleRepository: mockArticleRepository,
                                      readTokenInKeyChainUseCase: mockReadTokenInKeyChainUseCase)
    }

    func testExecute() async {
        guard let useCase = useCase else {
            return XCTFail("nil object")
        }

        do {
            let response = try await useCase.execute()

            XCTAssertEqual(response.count, mockArticleRepository.articles.count)
        } catch {
            XCTFail("Returned failed")
        }
    }

}

class MockArticleRepository: ArticleRepositoryProtocol {
    let articles = [
        Article(id: 1, title: "tst", body: "tst"),
        Article(id: 2, title: "tst2", body: "tst"),
        Article(id: 3, title: "tst3", body: "tst"),
    ]

    func getArticles(token: String) async throws -> [Article] {
        return articles
    }
}
