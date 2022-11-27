//
//  Contact.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import Foundation

struct Contact: Decodable {
    let firstName: String
    let lastName: String
    let statusIcon: String
    let statusMessage: String
    let gender: String?
}
