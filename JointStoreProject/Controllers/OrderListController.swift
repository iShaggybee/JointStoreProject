//
//  OrderListController.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 17.05.2022.
//

import UIKit

class OrderListController: UITableViewController {
    var delegate: LinkingTabBarViewController!
    
    private let orderManager = OrderManager.shared
    private var orderList: [Order] = []
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderList.isEmpty {
            noOrders()
        }
        
        return orderList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pushOrder", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let order = orderList[indexPath.row]
        
        content.text = "Заказ №\(order.number)"
        content.secondaryText = "\(order.items.count) позиций • \(order.totalPrice)₽ \nДата заказа: \(order.date)"

        cell.contentConfiguration = content
        return cell
    }
   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let orderVC = segue.destination as? OrderTableViewController else { return }
            orderVC.order = orderList[indexPath.row]
        }
    }
    
    private func loadData() {
        orderList = orderManager.getOrders()
        
        tableView.reloadData()
    }
}

extension OrderListController {
    func noOrders() {
        let alertController = UIAlertController(title: "Здесь пока пусто", message: "Перейдите в каталог, чтобы наполнить корзину", preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Перейти в каталог", style: .default) { _ in
            self.delegate.changeTabBarItem(on: .products)
        }
        
        alertController.view.tintColor = .red
        
        alertController.addAction(alertOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

