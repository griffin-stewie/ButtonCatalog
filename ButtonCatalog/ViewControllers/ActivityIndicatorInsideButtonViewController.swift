//
//  ActivityIndicatorInsideButtonViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/27.
//  
//

import UIKit

class ActivityIndicatorInsideButtonViewController: UIViewController {

    enum FavoriteStatus: CustomStringConvertible {
        case none
        case loading
        case marked

        func next() -> Self {
            switch self {
            case .none:
                return .loading
            case .loading:
                return .marked
            case .marked:
                return .none
            }
        }

        var description: String {
            switch self {
            case .none:
                return "none"
            case .loading:
                return "loading"
            case .marked:
                return "marked"
            }
        }
    }

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            favoriteButton,
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

    var isLoading: FavoriteStatus = .none {
        didSet {
            self.infoLabel.text = "Turned to \(isLoading.description)"
            favoriteButton.setNeedsUpdateConfiguration()
        }
    }

    lazy var favoriteButton = button()

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

    private func button() -> UIButton {
        var config: UIButton.Configuration = .borderless()
        config.image = UIImage(systemName: "heart")
        config.baseForegroundColor = .systemPink

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [weak self] _ in
            guard let self = self else {
                return
            }

            let status = self.isLoading.next()
            if status == .loading {
                self.fakeNetworking { [weak self] in
                    guard let self = self else {
                        return
                    }

                    self.isLoading =  self.isLoading.next()
                }
            }
            self.isLoading = status
        }))

        button.translatesAutoresizingMaskIntoConstraints = false

        button.configurationUpdateHandler = { [weak self] button in
            guard let self = self else {
                return
            }
            var config = button.configuration!
            switch self.isLoading {
            case .none:
                config.image = UIImage(systemName: "heart")
                config.showsActivityIndicator = false
            case .loading:
                config.showsActivityIndicator = true
            case .marked:
                config.image = UIImage(systemName: "heart.fill")
                config.showsActivityIndicator = false
            }
            button.configuration = config
        }

        return button
    }

    private func fakeNetworking(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            completion()
        }
    }
}
