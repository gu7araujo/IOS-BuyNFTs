//
//  ArticleViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 26/09/22.
//

import Combine
import Domain
import UIKit

class ArticleViewController: UIViewController {

    // MARK: - UI properties

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.cloud.rawValue
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        return tableView
    }()

    // MARK: - Private properties

    private var viewModel: ArticleViewModel?
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(_ viewModel: ArticleViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        buildTree()
        buildConstraints()
        setupBinders()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ArticleViewController deinit")
    }

    func buildTree() {
        view.addSubview(tableView)
    }

    func buildConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupBinders() {
        viewModel?.$error
            .receive(on: RunLoop.main)
            .sink { error in
                guard (error != nil ) else { return }
            }.store(in: &cancellables)

        viewModel?.$articles
            .receive(on: RunLoop.main)
            .sink { [weak self] articles in
                guard !articles.isEmpty else { return }
                self?.tableView.reloadData()
            }.store(in: &cancellables)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArticles()
    }

}

// MARK: - UITableViewDelegate
extension ArticleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleCell.preferredHeight
    }

}

// MARK: - UITableViewDataSource
extension ArticleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articles = viewModel?.articles else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell
        cell?.set(article: articles[indexPath.row])
        return cell ?? UITableViewCell()
    }

}
