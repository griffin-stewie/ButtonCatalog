//
//  RootTableViewController.swift
//  ButtonCatalog
//
//  Created by griffin-stewie on 2021/12/04.
//  
//

import UIKit

class RootTableViewController: UITableViewController {

    let cellIdentifier = "cell"

    enum Section: CaseIterable {
        case main
    }

    enum Navigation: CaseIterable {
        case configurationTypes
        case buttonSizes
        case imagePlacement
        case subtitleAndTextAlignment
        case multilineTitle
        case backgroundCustomization
        case updateButtonTitle
        case showActivityIndicatorInsideButton
        case toggleButton
        case popupButton
        case pulldownButton
        case deferredPulldownButton

        var title: String {
            switch self {
            case .configurationTypes:
                return "Configuration Types"
            case .buttonSizes:
                return "Button Sizes"
            case .imagePlacement:
                return "Image Placement"
            case .subtitleAndTextAlignment:
                return "Subtitle and TextAlignment"
            case .multilineTitle:
                return "Multiline Title"
            case .backgroundCustomization:
                return "Background Customization"
            case .updateButtonTitle:
                return "Update Button Title"
            case .showActivityIndicatorInsideButton:
                return "Show ActivityIndicator inside button"
            case .toggleButton:
                return "Toggle button"
            case .popupButton:
                return "Pop-up button"
            case .pulldownButton:
                return "Pull-down button"
            case .deferredPulldownButton:
                return "Deferred Pull-down button"
            }
        }

        var viewController: UIViewController {
            switch self {
            case .configurationTypes:
                return ConfigurationTypesViewController()
            case .buttonSizes:
                return ButtonSizesViewController()
            case .imagePlacement:
                return ImagePositionsViewController()
            case .subtitleAndTextAlignment:
                return TitleAlignmentsViewController()
            case .multilineTitle:
                return MultilineViewController()
            case .backgroundCustomization:
                return SimpleCustomBackgroundViewController()
            case .updateButtonTitle:
                return UpdateButtonTextViewController()
            case .showActivityIndicatorInsideButton:
                return ActivityIndicatorInsideButtonViewController()
            case .toggleButton:
                return ToggleViewController()
            case .popupButton:
                return PopupButtonViewController()
            case .pulldownButton:
                return PulldownButtonViewController()
            case .deferredPulldownButton:
                return DeferredPulldownButtonViewController()
            }
        }
    }

    lazy var dataSource: UITableViewDiffableDataSource<Section, Navigation> = {
        let id = cellIdentifier
        return UITableViewDiffableDataSource<Section, Navigation>(tableView: self.tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.title
            cell.contentConfiguration = config
            cell.accessoryType = .disclosureIndicator

            return cell
        }
    }()

    override var title: String? {
        get {
            return "Button Catalog"
        }
        set {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        var snapshot = NSDiffableDataSourceSnapshot<Section, Navigation>()

        snapshot.appendSections([.main])
        snapshot.appendItems(Navigation.allCases, toSection: .main)
        dataSource.apply(snapshot)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigation = dataSource.itemIdentifier(for: indexPath)!

        self.navigationController?.pushViewController(navigation.viewController, animated: true)
    }
}
