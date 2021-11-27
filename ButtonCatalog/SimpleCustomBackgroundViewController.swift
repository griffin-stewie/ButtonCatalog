//
//  SimpleCustomBackgroundViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/11/26.
//  
//

import UIKit

class SimpleCustomBackgroundViewController: UIViewController {

    lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [
            newButton(steps: []),
            newButton(steps: .step1),
            newButton(steps: [.step1, .step2]),
            newButton(steps: [.step1, .step2, .step3]),
            newButton(steps: [.step1, .step2, .step3, .step4]),
            newButton(steps: [.step1, .step2, .step3, .step4, .step5]),
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
        v.text = "背景をカスタマイズしていくとどうなるのか？"
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

    struct Step: OptionSet {
        let rawValue: UInt

        static let step1 = Step(rawValue: 1 << 0)
        static let step2 = Step(rawValue: 1 << 1)
        static let step3 = Step(rawValue: 1 << 2)
        static let step4 = Step(rawValue: 1 << 3)
        static let step5 = Step(rawValue: 1 << 4)
        static let step6 = Step(rawValue: 1 << 5)

        init(rawValue: UInt) {
            self.rawValue = rawValue
        }

        init(_ v: UInt) {
            self.rawValue = v
        }
    }

    private func newButton(steps: Step) -> UIButton {
        var config: UIButton.Configuration = .filled()
        config.title = "Send it!"
        var text = "filled"

        if steps.contains(.step1) {
            config.baseBackgroundColor = .systemGreen
            text = "add `baseBackgroundColor = .systemGreen`"
        }

        if steps.contains(.step2) {
            config.baseForegroundColor = .black
            text = "add `baseForegroundColor = .black`"
        }

        if steps.contains(.step3) {
            config.cornerStyle = .capsule
            text = "add `cornerStyle = .capsule`"
        }

        if steps.contains(.step4) {
            config.buttonSize = .large
            text = "add `buttonSize = .large`"
        }

        let button = UIButton(configuration: config, primaryAction: .init(handler: { [unowned self] _ in
            self.infoLabel.text = text }))
        button.translatesAutoresizingMaskIntoConstraints = false

        if steps.contains(.step5) {
            button.isEnabled = false
        }

        return button
    }
}
