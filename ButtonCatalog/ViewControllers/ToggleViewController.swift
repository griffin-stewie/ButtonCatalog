//
//  ToggleViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/27.
//  
//

import UIKit

class ToggleViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            showsOnlyFavoriteButton,
            listButton,
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
        v.text = "Show ActivityIndicator inside button"
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

    lazy var showsOnlyFavoriteButton = createShowsOnlyFavoriteButton()
    lazy var listButton = button()

    var onlyFavorite: Bool = false {
        didSet {
            showsOnlyFavoriteButton.setNeedsUpdateConfiguration()
        }
    }


    var showingList: Bool = false {
        didSet {
            listButton.setNeedsUpdateConfiguration()
        }
    }

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

    private func createShowsOnlyFavoriteButton() -> UIButton {
        var config: UIButton.Configuration = .plain()
        config.title = "shows only favorite"

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [unowned self] _ in
            self.onlyFavorite.toggle()
        }))

        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isSelected = onlyFavorite
        button.changesSelectionAsPrimaryAction = true

        return button
    }

    private func button() -> UIButton {
        var config: UIButton.Configuration = .borderless()
        config.image = UIImage(systemName: "list.bullet")
        config.automaticallyUpdateForSelection = false
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .lightGray

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [unowned self] _ in
            self.showingList.toggle()
        }))

        button.translatesAutoresizingMaskIntoConstraints = false

        button.configurationUpdateHandler = { button in
            var config = button.configuration!
            if button.isSelected {
                config.baseForegroundColor = .white
            } else {
                config.baseForegroundColor = .lightGray
            }
            button.configuration = config
        }

        button.isSelected = showingList
        button.changesSelectionAsPrimaryAction = true

        return button
    }
}
