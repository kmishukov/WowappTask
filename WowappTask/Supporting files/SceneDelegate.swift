//
//  SceneDelegate.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainCoordinator().start()
//        addTabBarViewController()
        window?.makeKeyAndVisible()
    }

    private func addTabBarViewController() {
        let tabBarController = UITabBarController()

        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem.title = "First"
        emptyViewController.view.backgroundColor = .white

        let contactsViewController = ContactsViewController()
        let navigationController = UINavigationController(rootViewController: contactsViewController)
        navigationController.tabBarItem.title = "Second"

        tabBarController.viewControllers = [emptyViewController, navigationController]
        tabBarController.viewWillAppear(true)
        window?.rootViewController = tabBarController
    }
}
