//
//  CartNavigationBar.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 13/10/22.
//

import UIKit
import Shared

class CartNavigationView: UIView {

    // MARK: - UI properties

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
        button.setBackgroundImage(UIImage(named: "shopping_cart", in: Bundle(for: CartNavigationView.self), with: .none), for: .normal)
        button.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        button.addSubview(cartBadge)
        return button
    }()

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero)
        buildTree()
        buildConstraints()
        backgroundColor = Colors.happiness.rawValue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildTree() {
        addSubview(cartButton)
    }

    func buildConstraints() {
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Methods

    @objc func cartTapped() {
        print("cart Tapped")
    }

    func set(badgeValue: Int) {
        cartBadge.text = String(badgeValue)
    }

}
