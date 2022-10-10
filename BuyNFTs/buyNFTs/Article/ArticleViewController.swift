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

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ArticleCollectionViewCell.self, forCellWithReuseIdentifier: ArticleCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Private properties

    private var viewModel: ArticleViewModel?

    // MARK: - Initialization

    init(_ viewModel: ArticleViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ArticleViewController deinit")
    }

    func buildTree() {
        view.addSubview(collectionView)
    }

    func buildConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        collectionView.backgroundColor = .purple
        view.backgroundColor = .purple
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getArticles()
    }

}

extension ArticleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCollectionViewCell.identifier, for: indexPath) as? ArticleCollectionViewCell
        cell?.article = viewModel?.articles[indexPath.row]

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.safeAreaLayoutGuide.layoutFrame.width - 20
        return CGSize(width: width, height: width)
    }
    
}

class ArticleCollectionViewCell: UICollectionViewCell {

    // MARK: - UI properties

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }()

    lazy var bodyLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()

    // MARK: - Properties

    var article: Article? {
        didSet {
            guard let article = article else { return }
            self.titleLabel.text = article.title
            self.bodyLabel.text = article.body
        }
    }

    static let identifier: String = "ArticleCollectionViewCell"

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildTree()
        buildConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("ArticleCollectionViewCell deinit")
    }

    func buildTree(){
        addSubview(titleLabel)
        addSubview(bodyLabel)
    }

    func buildConstraint() {
        titleLabel.backgroundColor = .yellow
        bodyLabel.backgroundColor = .green
        backgroundColor = .red
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
