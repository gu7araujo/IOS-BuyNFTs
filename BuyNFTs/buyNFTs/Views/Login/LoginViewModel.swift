//
//  ViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import Foundation
import Domain

protocol LoginViewModelProtocol {
    var errorPublished: Published<String?> { get }
    var errorPublisher: Published<String?>.Publisher { get }
    func doLogin(_ username: String, _ password: String)
}

final class LoginViewModel: LoginViewModelProtocol {

    @Published var error: String?
    var errorPublished: Published<String?> { _error }
    var errorPublisher: Published<String?>.Publisher { $error }

    let loginUseCase = LoginUseCase()

    func doLogin(_ username: String, _ password: String) {
        Task {
            let result = await loginUseCase.execute(userName: username, password: password)

            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
