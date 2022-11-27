//
//  ContactsBaseCoordinator.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

protocol ContactsBaseCoordinator: Coordinator {
    var parentCoordinator: MainCoordinator? { get set }
}
