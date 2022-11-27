//
//  MainCoordinator.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

enum MainTabs {
    case first
    case second
}

class MainCoordinator: MainBaseCoordinator {
    lazy var rootViewController: UIViewController = UITabBarController()
    lazy var contactsCoordinator: ContactsBaseCoordinator = ContactsCoordinator()

    var parentCoordinator: MainBaseCoordinator?

    func start() -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = .white
        emptyViewController.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)

        let contactsViewController = contactsCoordinator.start()
        contactsCoordinator.parentCoordinator = self
        contactsViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 1)

        (rootViewController as? UITabBarController)?.viewControllers = [emptyViewController, contactsViewController]
        
        return rootViewController
    }

    func moveTo(_ to: MainTabs) {
        switch to {
        case .first:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .second:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
}
