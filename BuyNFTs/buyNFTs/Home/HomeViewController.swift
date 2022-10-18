//
//  HomeViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Combine
import Domain

class HomeViewController: UIViewController {

    // MARK: - UI properties

    // create table view here

    // MARK: - Private properties

    private let navView = CartNavigationView()
    private var viewModel: HomeViewModel?
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(_ viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        setupConstraints()
        view.backgroundColor = Colors.cloud.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("HomeViewController deinit")
    }

    func setupConstraints() {
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func setupBinders() {
        viewModel?.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard (error != nil) else { return }
            }.store(in: &cancellables)

        viewModel?.$products
            .receive(on: RunLoop.main)
            .sink { [weak self] products in
                guard !products.isEmpty else { return }
            }.store(in: &cancellables)

        viewModel?.$cart
            .receive(on: RunLoop.main)
            .sink { [weak self] cart in
                guard let cart = cart else { return }
                self?.navView.set(badgeValue: cart.products.count)
            }.store(in: &cancellables)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupBinders()
        viewModel?.createShoopingCart()
        viewModel?.getProducts()
    }

}
