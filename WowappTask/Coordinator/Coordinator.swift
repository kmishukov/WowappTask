//
//  Coordinator.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }

    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
