//
//  UpdateButtonTextViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/26.
//  
//

import UIKit

class UpdateButtonTextViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            countUpButton(),
            cartButton,
        ])
        v.axis = .vertical
        v.alignment = .center

        v.spacing = 70
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textAlignment = .center
        v.text = "setNeedsUpdateConfiguration"
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

    var count: Int = 0 {
        didSet {
            cartButton.setNeedsUpdateConfiguration()
        }
    }

    lazy var cartButton = button()

    deinit {
        print("\(#file) \(#function), \(self)")
    }
    
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
            stackView.widthAnchor.constraint(equalToConstant: 200),

            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func countUpButton() -> UIButton {
        var config: UIButton.Configuration = .filled()
        config.image = UIImage(systemName: "cart.badge.plus")
        config.imagePlacement = .leading
        config.imagePadding = 7
        config.title = "カートに追加"

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [unowned self] _ in
            self.count += 1 }))
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    private func button() -> UIButton {
        var config: UIButton.Configuration = .filled()
        config.image = UIImage(systemName: "cart.fill")
        config.imagePlacement = .leading
        config.imagePadding = 7
        config.title = "購入へ"
        config.subtitle = count == 0 ? "カートは空っぽです。" : "カートには \(count) 個商品が入っています。"

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [unowned self] _ in
            self.infoLabel.text = "Tapped" }))
        button.translatesAutoresizingMaskIntoConstraints = false

        button.configurationUpdateHandler = { [weak self] button in
            guard let self = self else {
                preconditionFailure("not gonna happen")
            }
            var config = button.configuration!
            config.subtitle = self.count == 0 ? "カートは空っぽです。" : "カートには \(self.count) 個商品が入っています。"
            button.configuration = config
        }

        return button
    }

}
