//
//  CryptoCell.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 13/10/22.
//

import UIKit
import Domain

class CryptosCell: UITableViewCell {

    // MARK: - UI properties

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CryptoCell.self, forCellWithReuseIdentifier: "CryptoCell")
        return collectionView
    }()


    // MARK: - Public properties

    var didSendEventClosure: ((CryptosCell.Event) -> Void)?
    public static var preferredHeight: CGFloat = 100

    // MARK: - Private properties

    private var cryptos: [Product] = []

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
        contentView.addSubview(collectionView)
    }

    func buildConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func set(cryptos: [Product]) {
        self.cryptos = cryptos
        collectionView.reloadData()
    }
}

extension CryptosCell {
    enum Event {
        case openCryptoDetails(_ product: Product)
    }
}

// MARK: - UICollectionViewDelegate
extension CryptosCell: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let didSendEventClosure = self.didSendEventClosure else { fatalError("Closure didn't set") }
        didSendEventClosure(.openCryptoDetails(cryptos[indexPath.row]))
    }

}

// MARK: - UICollectionViewDataSource
extension CryptosCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cryptos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CryptoCell", for: indexPath) as? CryptoCell
        cell?.setImage(url: cryptos[indexPath.row].image)
        return cell ?? UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension CryptosCell: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CryptoCell.preferredSize
    }

}
