//
//  HomeViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 06/09/22.
//

import UIKit
import Combine
import Domain

class HomeViewController: UIViewController {

    private var products: [NFT] = []

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        view.setCollectionViewLayout(layout, animated: false)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    lazy var cartBadge: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.font = UIFont(name: "SanFranciscoText-Light", size: 13)
        label.textColor = .white
        label.backgroundColor = .red
        label.text = String(0)
        return label
    }()

    lazy var cartButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 16))
        button.setBackgroundImage(UIImage(named: "shopping_cart"), for: .normal)
        button.addTarget(self, action: "", for: .touchUpInside)
        button.addSubview(cartBadge)
        return button
    }()

    private var viewModel: HomeViewModelProtocol?
    private var cancellables: Set<AnyCancellable> = []

    init(_ viewModel: HomeViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        setupConstraints()
        setupBinders()
        viewModel?.createShoopingCart()
        viewModel?.getProducts()
    }

    func setupConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupBinders() {
        viewModel?.errorPublisher.sink { error in
            guard let error = error else {
                return
            }
            print(error)
        }.store(in: &cancellables)

        viewModel?.productsPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] products in
                self?.products = products
                self?.collectionView.reloadData()
            }).store(in: &cancellables)

        viewModel?.cartPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cart in
            guard let cart = cart else {
                return
            }
            self?.cartBadge.text = String(cart.products.count)
        }.store(in: &cancellables)
    }
}

// MARK: - UICollectionViewFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizes = UIScreen.main.bounds.width
        return CGSize(width: sizes, height: sizes)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        cell?.product = self.products[indexPath.row]
        cell?.addProductToShoopingCart = viewModel?.addProductToShoopingCart

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - HomeCollectionViewCell
class HomeCollectionViewCell: UICollectionViewCell {

    var product: NFT? {
        didSet {
            guard let product = product else { return }
            self.title.text = product.name
            self.price.text = String(product.price) + " ETH"
            image.downloaded(from: product.image)
        }
    }

    var addProductToShoopingCart: ((Product?) -> Void)?

    static let identifier: String = "CustomCollectionViewCell"

    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar ao carrinho", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80)
        ])

        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: image.bottomAnchor)
        ])

        addSubview(price)
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: title.bottomAnchor)
        ])

        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: price.bottomAnchor)
        ])
    }

    @objc func tapButton() {
        if let addProductToShoopingCart = addProductToShoopingCart {
            addProductToShoopingCart(product)
        }
    }
}