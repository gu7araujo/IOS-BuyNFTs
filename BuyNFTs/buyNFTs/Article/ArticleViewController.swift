//
//  ArticleViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 26/09/22.
//

import Domain
import UIKit

class ArticleViewController: UIViewController {

    // MARK: - UI properties



    // MARK: - Private properties

    private var viewModel: ArticleViewModel?

    // MARK: - Initialization

    init(_ viewModel: ArticleViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        buildTree()
        buildConstraints()
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

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArticles()
    }

}
