//
//  HomeViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    private var viewModel: HomeViewModelProtocol?
    private var cancellables: Set<AnyCancellable> = []

    init(_ viewModel: HomeViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupBinders()
        viewModel?.getProducts()
    }

    func setupBinders() {
        viewModel?.errorPublisher.sink { error in
            guard let error = error else {
                return
            }
            print(error)
        }.store(in: &cancellables)
    }
}
