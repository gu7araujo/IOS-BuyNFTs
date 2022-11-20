//
//  ArticleRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation
import Shared

public protocol ArticleRepositoryProtocol {
    func get() async throws -> [Article]
}

public class ArticleRepository: ArticleRepositoryProtocol {

    private var networkService: NetworkServiceProtocol
    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    public init(networkService: NetworkServiceProtocol,
                readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol) {
        self.networkService = networkService
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    public func get() async throws -> [Article] {
        let tokenResult = try readTokenInKeyChainUseCase.execute()
        let response = try await networkService.request(path: Router.getArticles.path, httpMethod: Router.getArticles.httpMethod, body: nil, headerAuthorization: tokenResult)

        do {
            let articlesResult = try JSONDecoder().decode([Article].self, from: response)
            return articlesResult
        } catch {
            fatalError("Json Decoder with Article in getArticles router")
        }
    }

}
