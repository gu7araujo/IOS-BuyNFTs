//
//  ArticleCompositionRoot.swift
//  Article
//
//  Created by Gustavo Araujo Santos on 20/11/22.
//

import Shared

final class ArticleCompositionRoot {

    static let shared = ArticleCompositionRoot()

    private init() { }

    /* Services */

    func buildArticleService() -> ArticleServiceProtocol {
        let networkService = SharedCompositionRoot.shared.buildNetworkService()
        let service = ArticleService(networkService: networkService)
        return service
    }

    /* Repositorys */

    func buildArticleRepository() -> ArticleRepositoryProtocol {
        let articleService = buildArticleService()
        let repository = ArticleRepository(articleService: articleService)
        return repository
    }

    /* UseCases */

    func buildListArticlesUseCase() -> ListArticlesUseCaseProtocol {
        let readTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildReadTokenInKeyChainUseCase()
        let articleRepository = buildArticleRepository()
        let useCase = ListArticlesUseCase(articleRepository: articleRepository,
                                          readTokenInKeyChainUseCase: readTokenInKeyChainUseCase)
        return useCase
    }

    /* ViewModels */

    func buildArticleViewModel() -> ArticleViewModel {
        let listArticlesUseCase = buildListArticlesUseCase()
        let vm = ArticleViewModel(listArticlesUseCase: listArticlesUseCase)
        return vm
    }

    /* ViewControllers */

    func buildArticleViewController(_ vm: ArticleViewModel) -> ArticleViewController {
        let vc = ArticleViewController(vm)
        return vc
    }

}
