//
//  ProductViewController.swift
//  JointStoreProject
//
//  Created by Андрей Барсук on 18.05.2022.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productDescriptionLabel: UILabel!
    
    var product: Product!
    private let shoppingCartManager = ShoppingCartManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.image = UIImage(named: "default_product_image")
        productNameLabel.text = product.name
        productPriceLabel.text = "$\(product.price)"
        productDescriptionLabel.text = product.description
    }
    
    @IBAction func addToCartButtonPressed() {
        shoppingCartManager.addProductItem(product: product, count: 1)
        self.showAddedToCartAlert(product)
    }
    
    func showAddedToCartAlert(_ product: Product) {
        
        let title = "Добавлено"
        let message = "Продукт '\(product.name)' добавлен в корзину. Продолжить покупки или перейти к корзине?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backToStoreAction = UIAlertAction(title: "Продолжить", style: .default)
        let goToCartAction = UIAlertAction(title: "Корзина", style: .default)
        alert.addAction(backToStoreAction)
        alert.addAction(goToCartAction)
        present(alert, animated: true)
    }
    
}

