//
//  PulldownViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/28.
//  
//

import UIKit

class PulldownButtonViewController: UIViewController {

    enum Cellular: String, CustomStringConvertible {
        case softbank
        case docomo
        case kddi

        var description: String {
            self.rawValue.capitalized
        }

        var identifier: UIAction.Identifier {
            UIAction.Identifier(self.rawValue)
        }

        func action(handler: @escaping UIActionHandler) -> UIAction {
            UIAction(title: "\"\(description)\"を使用", identifier: self.identifier, handler: handler)
        }
    }

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            simSelectorButton,
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
        v.text = "Pull-down button。Pop-up と違って現在の値を表すチェックマークが表示されない。"
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

    var selectedCellular: Cellular = .softbank {
        didSet {
            self.infoLabel.text = "Changed to \(selectedCellular.description)"
            simSelectorButton.setNeedsUpdateConfiguration()
        }
    }

    lazy var simSelectorButton = button()

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
        // Pop-up button

        let closure = { [weak self] (action: UIAction) in
            print(action.identifier)

            self?.selectedCellular = Cellular(rawValue: action.identifier.rawValue)!
        }

        let button = UIButton(primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config: UIButton.Configuration = .bordered()
        config.title = self.selectedCellular.description
        config.baseForegroundColor = .darkText

        button.configurationUpdateHandler = { [weak self] button in
            guard let self = self else {
                return
            }

            var config = button.configuration!
            config.title = self.selectedCellular.description

            button.configuration = config
        }

        button.menu = UIMenu(title: "使用する回線を選択してください。",children: [
            Cellular.softbank.action(handler: closure),
            Cellular.docomo.action(handler: closure),
        ])

        button.showsMenuAsPrimaryAction = true
        
        button.configuration = config

        return button
    }

}
