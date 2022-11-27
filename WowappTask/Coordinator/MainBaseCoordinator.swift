//
//  MainBaseCoordinator.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

protocol MainBaseCoordinator: Coordinator {
    var contactsCoordinator: ContactsBaseCoordinator { get }
    func moveTo(_ to: MainTabs)
}
