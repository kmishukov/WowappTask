//
//  ContactTableViewCell.swift
//  WowappTask
//
//  Created by Konstantin Mishukov on 27.11.2022.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    static let cellIdentifier = "ContactTableViewCell"

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    func updateWith(viewModel: ContactCellViewModel) {
        nameLabel.text = viewModel.firstName + " " + viewModel.lastName
        statusLabel.text = viewModel.statusMessage.isEmpty ? nil : viewModel.statusMessage
        avatarImage.image = UIImage(named: viewModel.avatar)
        statusImage.image = UIImage(named: viewModel.statusIcon)
    }
}
