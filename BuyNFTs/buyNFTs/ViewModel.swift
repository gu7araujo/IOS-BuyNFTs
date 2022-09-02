//
//  ViewModel.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 02/09/22.
//

import Domain
import Foundation

class ViewModel {

    @Published var error: String?
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
