//
//  ContactCellViewModel.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import Foundation

protocol ContactCellViewModel {
    var firstName: String { get }
    var lastName: String { get }
    var statusIcon: String { get }
    var statusMessage: String { get }
    var avatar: String { get }
}
