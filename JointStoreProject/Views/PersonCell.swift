//
//  PersonCell.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 29.05.2022.
//

import UIKit

class PersonCell: UITableViewCell {
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var logoImage: UIImageView!
    
    func configure(person: Person) {
        selectionStyle = .none
        fullNameLabel.text = person.getFullName()
        logoImage.image = UIImage(named: person.getFullName())
        logoImage.layer.cornerRadius = logoImage.frame.height / 2
    }
}
