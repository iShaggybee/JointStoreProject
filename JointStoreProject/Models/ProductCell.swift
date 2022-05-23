//
//  ProductCell.swift
//  JointStoreProject
//
//  Created by Андрей Барсук on 18.05.2022.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productDescriptionLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    
    var addToCart: (() -> ()) = {}

    @IBAction func addToCartButtonPressed() {
        addToCart()
    }
}
