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

    // MARK: - UI properties

    lazy var loginField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.placeholder = NSLocalizedString("LoginViewController.login", comment: "")
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.font = Typography.p1Light.rawValue
        return field
    }()

    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.placeholder = NSLocalizedString("LoginViewController.password", comment: "")
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.font = Typography.p1Light.rawValue
        return field
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("LoginViewController.loginButton", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        button.titleLabel?.font = Typography.p1Light.rawValue
        return button
    }()

    // MARK: - Private properties

    private var viewModel: LoginViewModel?
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initialization

    init(_ viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("LoginViewController deinit")
    }

    func setupConstraints() {
        view.addSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 150),
            passwordField.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(loginField)
        NSLayoutConstraint.activate([
            loginField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -10),
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.widthAnchor.constraint(equalToConstant: 150),
            loginField.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupBinders()
    }

    // MARK: - Methods

    func setupBinders() {
        viewModel?.$error
            .receive(on: RunLoop.main)
            .sink { error in
                guard (error != nil) else { return }
                self.loginButton.setTitleColor(.red, for: .normal)
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
