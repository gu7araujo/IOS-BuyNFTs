//
//  ProductDetails.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 16/09/22.
//

import UIKit
import Domain

class ProductDetailsViewController: UIViewController {

    private var product: Product?

    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = product?.name
        return label
    }()

    lazy var artImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32."
        return label
    }()

    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        scroll.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 10)
        ])

        artImage.downloaded(from: product?.image ?? "")
        scroll.addSubview(artImage)
        NSLayoutConstraint.activate([
            artImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            artImage.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            artImage.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: 10),
            artImage.heightAnchor.constraint(equalToConstant: 350)
        ])

        scroll.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: artImage.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -10)
        ])
    }

}
