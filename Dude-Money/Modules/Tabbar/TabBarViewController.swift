//
//  TabBarViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

import UIKit

protocol TabBarViewInterface: AnyObject {
    func setupView()
}

class TabBarViewController: UITabBarController {
    
    private lazy var mockVC: UIViewController = {
        let navigationController = UINavigationController()
        let mockViewController = MockViewController()
        navigationController.viewControllers = [mockViewController]
        navigationController.tabBarItem.title = "Mock"
        navigationController.tabBarItem.image = UIImage(systemName: "homekit")!
        return navigationController
    }()
    
    var presenter: TabBarPresenterInterface? {
        didSet {
            presenter?.notifyViewLoaded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Interface Setup
extension TabBarViewController: TabBarViewInterface {
    
    func setupView() {
        viewControllers = [
            mockVC,
        ]
    }
}

// TODO: When completed that project delete this
class MockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
