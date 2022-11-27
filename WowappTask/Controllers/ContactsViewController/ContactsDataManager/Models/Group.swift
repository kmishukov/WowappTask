//
//  Group.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import Foundation

struct Groups: Decodable {
    let groups: [Group]
}

struct Group: Decodable {
    let groupName: String
    let people: [Contact]

    enum CodingKeys: CodingKey {
        case groupName
        case people
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.groupName = try container.decode(String.self, forKey: .groupName)
        self.people = try container.decode([Contact].self, forKey: .people).sorted { $0.firstName < $1.firstName }
    }
}
