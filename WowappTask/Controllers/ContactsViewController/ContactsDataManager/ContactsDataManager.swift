//
//  ContactsDataManager.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import Foundation

final class ContactsDataManager {
    private var groups: [Group] = []

    // MARK: - Interface

    func loadContacts(completion: @escaping (Bool) -> Void) {
        let urlStr = "https://file.wowapp.me/owncloud/index.php/s/gK2GDTQMkHEuF5o/download"
        NetworkManager.request(url: urlStr, parameter: nil) { [weak self] networkResponse in
            guard let self = self else { return }
            if let data = networkResponse.data,
               let contacts = try? JSONDecoder().decode(Groups.self, from: data) {
                self.groups = contacts.groups
                    .compactMap { $0.people.isEmpty ? nil : $0 }
                    .sorted { $0.groupName < $1.groupName }
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func numberOfGroups() -> Int {
        groups.count
    }

    func titleForGroup(_ index: Int) -> String {
        groups[index].groupName
    }

    func numberOfRows(groupIndex index: Int) -> Int {
        groups[index].people.count
    }

    func contact(groupIndex: Int, contactIndex: Int) -> ContactViewModel {
        let person = groups[groupIndex].people[contactIndex]
        return ContactViewModel(firstName: person.firstName,
                                lastName: person.lastName,
                                statusIcon: person.statusIcon,
                                statusMessage: person.statusMessage,
                                avatar: avatarForGender(person.gender)
            )
    }

    // MARK: - Private methods

    private func avatarForGender(_ gender: String?) -> String {
        switch gender {
        case "male":
            return "avatarMale"
        case "female":
            return "avatarFemale"
        default:
            return "avatarUnknown"
        }
    }
}
