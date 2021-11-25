//
//  ConfigurationTypesViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/25.
//  
//

import UIKit

class ConfigurationTypesViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            button(configurationProvider: {
                    .plain()
            }, actionHandler: { [unowned self] _ in
                self.infoLabel.text = "plain"
            }),
            button(configurationProvider: {
                    .gray()
            }, actionHandler: { [unowned self] _ in
                self.infoLabel.text = "gray"
            }),

            button(configurationProvider: {
                return .tinted()
            }, actionHandler: { [unowned self] _ in
                self.infoLabel.text = "tinted"
            }),

            button(configurationProvider: {
                return .filled()
            }, actionHandler: { [unowned self] _ in
                self.infoLabel.text = "filled"
            }),
        ])
        v.axis = .vertical
        v.alignment = .center

        v.spacing = 30
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textAlignment = .center
        v.text = "デフォルトで用意されている4つの Configuration による見た目の違い"
        v.font = UIFont.preferredFont(forTextStyle: .headline)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var infoLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        view.addSubview(infoLabel)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func button(configurationProvider: () -> UIButton.Configuration, actionHandler: @escaping UIActionHandler) -> UIButton {
        let signInButton = UIButton(configuration: configurationProvider(), primaryAction: .init(handler: actionHandler))
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign In", for: [])
        signInButton.configuration = configurationProvider()

        return signInButton
    }

}

