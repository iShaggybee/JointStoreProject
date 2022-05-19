//
//  ProductListViewController.swift
//  JointStoreProject
//
//  Created by Андрей Барсук on 18.05.2022.
//

import UIKit

class ProductListViewController: UITableViewController {
    private var products = StoreManager.shared.products
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        showSearchAlert()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        
        cell.selectionStyle = .none
        cell.productImageView.image = UIImage(named: "default_product_image")
        cell.productNameLabel.text = product.name
        cell.productDescriptionLabel.text = product.description
        cell.productPriceLabel.text = "$\(product.price)"
        cell.addToCart = {
            ShoppingCartManager.shared.addProductItem(product: product, count: 1)
            print("Added to cart: \(product.name)") // Удалить
            self.showAddedToCartAlert(product)
        }
        
        return cell
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
    
    func showSearchAlert() {
        let alert = UIAlertController(title: "Найти в каталоге", message: "", preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Найти", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if textField.text != "" {
                self.products = StoreManager.shared.searchProducts(by: textField.text!)
                DispatchQueue.main.async { self.tableView.reloadData() }
            } else {
                self.products = StoreManager.shared.products
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
            
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alert.addTextField()
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard let productVC = segue.destination as? ProductViewController else { return }
     guard let indexPath = tableView.indexPathForSelectedRow else { return }
     let product = products[indexPath.row]
     
     productVC.product = product
     }

}

