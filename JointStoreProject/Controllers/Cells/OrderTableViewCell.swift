//
//  OrderTableViewCell.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 19.05.2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var productsImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        productsImage.layer.cornerRadius = 10
    }
}