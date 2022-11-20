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

    /* Repositorys */

    func buildArticleRepository() -> ArticleRepositoryProtocol {
        let networkService = SharedCompositionRoot.shared.buildNetworkService()
        let readTokenInKeyChainUseCase = SharedCompositionRoot.shared.buildReadTokenInKeyChainUseCase()
        let repository = ArticleRepository(networkService: networkService,
                                           readTokenInKeyChainUseCase: readTokenInKeyChainUseCase)
        return repository
    }

    /* UseCases */

    func buildListArticlesUseCase() -> ListArticlesUseCaseProtocol {
        let articleRepository = buildArticleRepository()
        let useCase = ListArticlesUseCase(articleRepository: articleRepository)
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
