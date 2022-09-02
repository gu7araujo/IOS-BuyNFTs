//
//  ViewController.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 01/09/22.
//

import UIKit
import Combine
import Domain

class LoginViewController: UIViewController {

    lazy var loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .white
        field.font = .systemFont(ofSize: 20)
        field.placeholder = "login"
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        return field
    }()

    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textColor = .white
        field.font = .systemFont(ofSize: 20)
        field.placeholder = "password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        return field
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("do Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        return button
    }()

    private var viewModel: LoginViewModelProtocol?
    private var cancellables: Set<AnyCancellable> = []

    init(_ viewModel: LoginViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupBinders()
    }

    func setupConstraints() {
        view.addSubview(loginField)
        NSLayoutConstraint.activate([
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginField.widthAnchor.constraint(equalToConstant: 150),
            loginField.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 10),
            passwordField.widthAnchor.constraint(equalToConstant: 150),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupBinders() {
        viewModel?.errorPublisher.sink { error in
            guard let error = error else {
                return
            }
            print(error)
        }.store(in: &cancellables)
    }

    @objc func loginButtonClick() {
        guard let username = loginField.text,
              username != "",
              let password = passwordField.text,
              password != "" else {
            return
        }

        viewModel?.doLogin(username, password)
    }
}
