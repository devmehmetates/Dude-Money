//
//  TabBarViewController.swift
//  Dude-Money
//
//  Created by Mehmet Ateş on 13.08.2022.
//

import UIKit

protocol TabBarViewInterface {
    func setupView()
}

class TabBarViewController: UITabBarController {
    
    var presenter: TabBarPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
}

// MARK: - View Setup
extension TabBarViewController: TabBarViewInterface {
    
    func setupView() {
        viewControllers = [
            configureTabbarButton(for: MockViewController(), title: "Mock", image: UIImage(systemName: "homekit")!),
            configureTabbarButton(for: MockViewController(), title: "Mock2", image: UIImage(systemName: "homekit")!),
            configureTabbarButton(for: MockViewController(), title: "Mock3", image: UIImage(systemName: "homekit")!),
            configureTabbarButton(for: MockViewController(), title: "Mock4", image: UIImage(systemName: "homekit")!)
        ]
    }
    
    private func configureTabbarButton(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}

class MockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
