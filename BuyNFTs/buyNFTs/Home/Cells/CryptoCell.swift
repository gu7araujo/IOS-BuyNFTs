//
//  CryptoCell.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 18/10/22.
//

import UIKit

class CryptoCell: UICollectionViewCell {

    // MARK: - UI properties

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CryptoCell.preferredSize.width / 2
        return imageView
    }()

    // MARK: - Public properties

    public static var preferredSize: CGSize = CGSize(width: 80, height: 80)

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildTree()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildTree() {
        contentView.addSubview(imageView)
    }

    private func setupConstraints() {
        setupImageViewConstraints()
    }

    private func setupImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    public func setImage(url: String) {
        imageView.loadImage(url: url)
    }

}
