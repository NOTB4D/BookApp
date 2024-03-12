//
//  MainTabBarViewController.swift
//  BookApp
//
//  Created by Eser Kucuker on 11.03.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    var tabBarItemWidth: CGFloat {
        UIScreen.main.bounds.width / CGFloat(MainTabs.caseCount)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.isHidden = true
        updateUI()
    }

    func routeTo(_ mainTabs: MainTabs) {
        selectedIndex = mainTabs.rawValue
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    override public func tabBar(_: UITabBar, didSelect _: UITabBarItem) {
        // nothing to handle
    }

    public func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
        // nothing to handle
    }
}

extension MainTabBarViewController {
    func updateUI() {
        tabBar.isHidden = false
        // will be handled
        viewControllers = [
            "Home", "Main", "Main",
        ].compactMap { createTabViewController(in: $0) }
        setTabButton()

        let appearance = createAppearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    func getAttributedString(selected _: Bool) -> [NSAttributedString.Key: Any] {
        [
            .font: UIFont(name: "Helvetica", size: 12) ?? .systemFont(ofSize: 12),
            .foregroundColor: UIColor.secondaryLabel,
        ]
    }

    private func createTabViewController(in storyboardName: String) -> UINavigationController {
        let controller: UINavigationController = UIApplication.getViewController(
            inScene: storyboardName, isInitialViewController: true
        )
        return controller
    }

    private func setTabButton() {
        guard let items = tabBar.items else { return }
        for index in 0 ..< items.count {
            items[index].title = MainTabs(rawValue: index)?.title
            if index == MainTabs.home.rawValue {
                items[index].image = UIImage(systemName: "homekit")
            }
            if index == MainTabs.search.rawValue {
                items[index].image = UIImage(systemName: "magnifyingglass")
            }
            if index == MainTabs.favorite.rawValue {
                items[index].image = UIImage(systemName: "heart.fill")
            }
        }
    }
}
