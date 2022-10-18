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
        view.backgroundColor = Colors.cloud.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ArticleViewController deinit")
    }

    func buildTree() {

    }

    func buildConstraints() {

    }

    func setupBinders() {
        viewModel?.$error
            .receive(on: RunLoop.main)
            .sink { error in
                guard (error != nil ) else { return }
            }.store(in: &cancellables)

        viewModel?.$articles
            .receive(on: RunLoop.main)
            .sink { articles in
                guard !articles.isEmpty else { return }
            }.store(in: &cancellables)
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArticles()
    }

}
