//
//  ContactsCoordinator.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

class ContactsCoordinator: ContactsBaseCoordinator {
    var parentCoordinator: MainCoordinator?
    lazy var rootViewController = UIViewController()

    func start() -> UIViewController {
        let contactsVC = ContactsViewController()
        contactsVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: contactsVC)
        return rootViewController
    }
}
