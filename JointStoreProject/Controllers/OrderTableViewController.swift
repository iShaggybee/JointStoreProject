//
//  OrderTableViewController.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 19.05.2022.
//

import UIKit

class OrderTableViewController: UITableViewController {
    var order: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = String("Заказ № \(order.number) от \(order.date)")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderTableViewCell
        let productItem = order.items[indexPath.row]
        let product = productItem.product
        
        cell.productsImage.image = UIImage(named: product.name)
        cell.itemLabel.text = product.name
        cell.priceWithCountLabel.text = "\(product.price) ₽ x \(productItem.count) \(product.unit.rawValue)"
        cell.totalPriceLabel.text = "Всего \(productItem.getTotalPrice()) ₽"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        String("Общая цена: \(order.totalPrice)₽")
    }
}

