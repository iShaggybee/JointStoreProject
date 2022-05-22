//
//  OrderTableViewCell.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 19.05.2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var productsImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var nameImage: String = ""
    
    override func awakeFromNib() {
        nameImage = "photo"
        productsImageView.image = UIImage(named: nameImage)
        productsImageView.layer.cornerRadius = 10
    }
}
