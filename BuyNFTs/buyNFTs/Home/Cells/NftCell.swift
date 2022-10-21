//
//  NftCell.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 13/10/22.
//

import UIKit
import Domain

class NftCell: UITableViewCell {

    // MARK: - UI properties

    private lazy var image = UIImageView ()

    // MARK: - Public properties

    public static var preferredHeight: CGFloat = 400

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = Colors.cloud.rawValue
        buildTree()
        buildConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildTree() {
        contentView.addSubview(image)
    }

    func buildConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func set(nft: Product) {
        self.image.loadImage(url: nft.image)
    }

}

extension NftCell {
    enum Event {
        case openNftDetails(_ product: Product)
    }
}
