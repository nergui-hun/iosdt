//
//  LoginViewController.swift
//  FileManager
//
//  Created by M M on 1/18/23.
//

import Foundation
import UIKit
import SnapKit

enum ScreenMode {
    case normal
    case changePassword
}

final class LoginViewController: UIViewController {
    // MARK: - Values
    var delegate: LoginViewControllerDelegate?
    private var mode: ScreenMode
    private let keychain = KeychainService.shared
    
    // MARK: - View Elements
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = UIColor(named: "aliceblue")
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    } ()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        return textField
    } ()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        return label
    } ()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(managePassword), for: .touchUpInside)
        return button
    } ()

    // MARK: - init
    init(mode: ScreenMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        keychain.removeData(key: "password1")
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "aliceblue")

        if let pass = keychain.getData(key: "password") {
            passwordTextField.placeholder = "Введите пароль"
        } else {
            passwordTextField.placeholder = "Создать пароль"
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginButton)

        let stackViewHeight = 125 + 5 + 16

        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.center)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(stackViewHeight)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(25)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func passwordsDontMatch() {
        passwordTextField.text?.removeAll()
        passwordTextField.placeholder = "Создать пароль"
        errorLabel.text = "Пароли не совпадают"
        keychain.removeData(key: "password1")
    }

    @objc func managePassword(_ sender: UIButton!) {
        if let password = passwordTextField.text {

            if password.count < 4 {
                errorLabel.text = "Пароль должен состоять минимум из четырёх символов"
            } else {

                if let password1 = keychain.getData(key: "password1") {

                    //the 2 passwords match
                    if password1 == password {
                        if let savedPassword = keychain.getData(key: "password") {

                            if self.mode == .changePassword {
                                keychain.removeData(key: "password")
                                keychain.saveData(value: password, key: "password")
                                self.mode = .normal
                                self.dismiss(animated: true)
                            }

                            //log in
                            if password == savedPassword {
                                self.delegate?.logIn()
                            } else {
                                passwordsDontMatch()
                            }
                        } else {
                            keychain.saveData(value: password, key: "password")
                            self.delegate?.logIn()
                        }

                    //the 2 passwords don't match
                    } else {
                        passwordsDontMatch()
                    }

                } else {
                    passwordTextField.text?.removeAll()
                    passwordTextField.placeholder = "Повторите пароль"
                    keychain.saveData(value: password, key: "password1")
                    errorLabel.text = ""
                }
            }
        }
    }
    // MARK: - Observers

    // MARK: - Extensions
}
