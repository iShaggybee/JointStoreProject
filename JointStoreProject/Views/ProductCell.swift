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
    
    var addToCart: (() -> Void)?

    @IBAction func addToCartButtonPressed() {
        addToCart?()
    }
    
    func configure(product: Product, actionAddToCart: @escaping () -> Void) {
        selectionStyle = .none
        productImageView.image = UIImage(named: product.name)
        productNameLabel.text = product.name
        productDescriptionLabel.text = product.description
        productPriceLabel.text = "\(product.price)₽/\(product.unit.rawValue)"
        addToCart = actionAddToCart
    }
}
