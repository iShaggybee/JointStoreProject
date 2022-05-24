//
//  OrderListController.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 17.05.2022.
//

import UIKit

class OrderListController: UITableViewController {
    private let listOrder = OrderManager.shared.getOrders()
   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listOrder.count == 0 {
            noOrders()
        }
        return listOrder.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pushOrder", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let order = listOrder[indexPath.row]
        
        content.text = "Заказ №\(order.number)"
        content.secondaryText = "\(order.items.count) позиций • \(order.totalPrice)₽ \nДата заказа: \(order.date)"

        cell.contentConfiguration = content
        return cell
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let orderVC = segue.destination as? OrderTableViewController else { return }
            orderVC.order = listOrder[indexPath.row]
        }
    }
}

extension OrderListController {
    func noOrders() {
        let alertController = UIAlertController(title: "Здесь пока пусто", message: "Перейдите в каталог, чтобы наполнить корзину", preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Перейти в каталог", style: .default, handler: nil)
        
        alertController.view.tintColor = .red
        
        alertController.addAction(alertOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

