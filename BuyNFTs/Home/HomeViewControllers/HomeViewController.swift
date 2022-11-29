//
//  HomeViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Combine
import Shared

class HomeViewController: UIViewController {

    // MARK: - UI properties

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.cloud.rawValue
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CryptosCell.self, forCellReuseIdentifier: "CryptosCell")
        tableView.register(NftCell.self, forCellReuseIdentifier: "NftCell")
        return tableView
    }()

    // MARK: - Private properties

    private let navView = CartNavigationView()
    private var viewModel: HomeViewModel?
    private var cancellables: Set<AnyCancellable> = []
    private var cryptos: [Product] = []
    private var nfts: [Product] = []

    // MARK: - Public properties

    var didSendEventsClosure: ((Any) -> Void)?

    // MARK: - Initialization

    init(_ viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        buildTree()
        setupConstraints()
        setupBinders()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("HomeViewController deinit")
    }

    func buildTree() {
        view.addSubview(navView)
        view.addSubview(tableView)
    }

    func setupConstraints() {
        setupNavigationViewConstraints()
        setupTableViewConstraints()
    }

    func setupNavigationViewConstraints() {
        navView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBinders() {
        viewModel?.$error
            .receive(on: RunLoop.main)
            .sink { error in
                guard (error != nil) else { return }
            }.store(in: &cancellables)

        viewModel?.$products
            .receive(on: RunLoop.main)
            .sink { [weak self] products in
                guard !products.isEmpty else { return }
                self?.cryptos = products.filter { $0.type == .crypto }
                self?.nfts = products.filter { $0.type == .nft }
                self?.tableView.reloadData()
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
        viewModel?.createShoppingCart()
        viewModel?.getProducts()
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CryptosCell.preferredHeight
        } else {
            return NftCell.preferredHeight
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let didSendEventClosure = self.didSendEventsClosure else { fatalError("Closure didn't set") }
        didSendEventClosure(NftCell.Event.openNftDetails(nfts[indexPath.row - 1]))
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !nfts.isEmpty else { return 0 }
        var quantityTableViewRows = 1 // begging with collection view and show nfts.
        quantityTableViewRows += nfts.count
        return quantityTableViewRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !nfts.isEmpty, !cryptos.isEmpty else { return UITableViewCell() }

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CryptosCell", for: indexPath) as? CryptosCell
            cell?.didSendEventClosure = didSendEventsClosure
            cell?.set(cryptos: cryptos)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NftCell", for: indexPath) as? NftCell
            cell?.set(nft: nfts[indexPath.row - 1])
            return cell ?? UITableViewCell()
        }

    }

}
