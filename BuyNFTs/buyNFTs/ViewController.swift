//
//  ViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 01/09/22.
//

import UIKit
import Domain

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let loginUseCase = LoginUseCase()

        Task {
            let result = await loginUseCase.execute(userName: "gustavosantos", password: "123456")

            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
    }


}

