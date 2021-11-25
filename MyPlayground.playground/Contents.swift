//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {

    lazy var sampleButton = button()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        view.addSubview(sampleButton)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLayoutConstraint.activate([
            sampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sampleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func button() -> UIButton {
        let signInButton = UIButton(type: .system, primaryAction: .init(handler: { action in
            print("tapped")
        }))
        signInButton.configuration = .filled()
        signInButton.configuration?.buttonSize = .mini
        signInButton.setTitle("Sign In", for: [])
        return signInButton
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
