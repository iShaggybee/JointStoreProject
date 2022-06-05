//
//  OrderTableViewCell.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 19.05.2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet var productsImage: UIImageView!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var priceWithCountLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    
    func configure(productItem: ProductItem) {
        let product = productItem.product
        
        productsImage.image = UIImage(named: product.name)
        itemLabel.text = product.name
        priceWithCountLabel.text = "\(product.price) ₽ x \(productItem.count) \(product.unit.rawValue)"
        totalPriceLabel.text = "Всего \(productItem.getTotalPrice()) ₽"
    }
}
