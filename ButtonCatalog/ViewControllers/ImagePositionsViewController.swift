//
//  ImagePositionsViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/25.
//  
//

import UIKit

class ImagePositionsViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            button(text: "leading", imagePlacement: .leading),
            button(text: "top", imagePlacement: .top),
            button(text: "trailing", imagePlacement: .trailing),
            button(text: "bottom", imagePlacement: .bottom),
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
        v.text = "デフォルトで用意されている4つの画像の表示位置による見た目の違い"
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

            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func button(text: String, size: UIButton.Configuration.Size = .medium, imagePlacement: NSDirectionalRectEdge) -> UIButton {
        button(configurationProvider: {
            var config: UIButton.Configuration = .filled()
            config.buttonSize = size
            config.title = "Send it"
            config.image = UIImage(systemName: "paperplane.fill")
            config.imagePlacement = imagePlacement
            config.imagePadding = 7
            return config
        }, actionHandler: { [unowned self] _ in
            self.infoLabel.text = text
        })
    }

    private func button(configurationProvider: () -> UIButton.Configuration, actionHandler: @escaping UIActionHandler) -> UIButton {
        let signInButton = UIButton(configuration: configurationProvider(), primaryAction: .init(handler: actionHandler))
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = configurationProvider()

        return signInButton
    }

}
