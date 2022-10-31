//
//  ArticleCell.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 13/10/22.
//

import UIKit
import Domain

class ArticleCell: UITableViewCell {

    // MARK: - UI properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.h1.rawValue
        label.numberOfLines = 0
        return label
    }()

    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Public properties

    public static var preferredHeight: CGFloat = 360

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        buildTree()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildTree() {
        addSubview(titleLabel)
        addSubview(bodyLabel)
    }

    func buildConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 70)
        ])

        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }

    // MARK: - Public methods

    func set(article: Article) {
        titleLabel.text = article.title
        bodyLabel.text = article.body
    }

}
