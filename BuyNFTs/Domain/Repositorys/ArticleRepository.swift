//
//  ArticleRepository.swift
//  Domain
//
//  Created by Gustavo Araujo Santos on 03/10/22.
//

import Foundation
import Infrastructure

public protocol ArticleRepositoryProtocol {
    func get() async -> Result<[Article], Error>
}

public class ArticleRepository: ArticleRepositoryProtocol {

    private var networkService: NetworkServiceProtocol
    private var readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol

    public init(networkService: NetworkServiceProtocol = NetworkService(), readTokenInKeyChainUseCase: ReadTokenInKeyChainUseCaseProtocol = ReadTokenInKeyChainUseCase()) {
        self.networkService = networkService
        self.readTokenInKeyChainUseCase = readTokenInKeyChainUseCase
    }

    public func get() async -> Result<[Article], Error> {
        var token = ""
        var articles: [Article] = []

        do {
            token = try readTokenInKeyChainUseCase.execute()
        } catch {
            return .failure(error)
        }

        let result = await networkService.request(path: Router.getArticles.path, httpMethod: Router.getArticles.httpMethod, body: nil, headerAuthorization: token)
        switch result {
        case .success(let data):
            do {
                articles = try JSONDecoder().decode([Article].self, from: data)

                return .success(articles)
            } catch {
                fatalError("Json Decoder with Article in getArticles router")
            }
        case .failure(let error):
            return .failure(error)
        }
    }

}
