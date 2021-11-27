//
//  MultilineViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/26.
//  
//

import UIKit

/***
 titile に与える文字列に改行文字が含まれていると改行されて表示される。改行文字が含まれていない場合でもボタンの幅指定がある場合には自動で折り返される。逆に幅指定が無い場合には改行なしの長文はそのまま横に伸びて画面から見切れる。
 subtitle を使っていないので textAlignment の値は、テキストのレイアウトに影響を与えない。
**/

class MultilineViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            button(text: "leading", titleAlignment: .leading),
            button(text: "center", titleAlignment: .center),
            button(text: "trailing", titleAlignment: .trailing),
            button(text: "title\nwith newline", titleAlignment: .automatic),
            button(text: "automatic but image placed top", imagePlacement: .top, titleAlignment: .automatic),
            button(text: "It's just long text. I will repeat it over and over again.", imagePlacement: .trailing, titleAlignment: .automatic),
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
        v.text = "タイトル文字に長い文字や改行ありの文字列を与えた場合はどうなるか？"
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
            stackView.widthAnchor.constraint(equalToConstant: 200),

            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func button(text: String, configuration: UIButton.Configuration = .filled(), size: UIButton.Configuration.Size = .medium, imagePlacement: NSDirectionalRectEdge = .leading, titleAlignment: UIButton.Configuration.TitleAlignment = .automatic) -> UIButton {
        button(configurationProvider: {
            var config: UIButton.Configuration = configuration
            config.buttonSize = size
            config.titleAlignment = titleAlignment
            config.title = text
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
