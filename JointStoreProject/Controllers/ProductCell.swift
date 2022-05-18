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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addToCartButtonPressed() {
        addToCart()
    }
    
}
