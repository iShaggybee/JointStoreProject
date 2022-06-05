//
//  OrderListController.swift
//  JointStoreProject
//
//  Created by Борис Павлов on 17.05.2022.
//

import UIKit

class OrderListController: UITableViewController {
    var delegate: LinkingTabBarVCDelegate!
    
    private let orderManager = OrderManager.shared
    private var orderList: [Order] = [] {
        didSet {
            let hidden = !orderList.isEmpty

            backgroundView.isHidden = hidden
            navigationController?.setNavigationBarHidden(!hidden, animated: false)
        }
    }
    private let backgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pushOrder", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let order = orderList[indexPath.row]
        
        content.text = "Заказ № \(order.number)"
        content.secondaryText = "\(order.items.count) позиций • \(order.totalPrice)₽ \nДата заказа: \(order.date)"
        content.image = UIImage(named: "order")

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
    private func setBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height / 2))
        
        label.text = "Вы пока ничего не заказывали :("
        label.textColor = .lightGray
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.textAlignment = .center
        
        let imageViewBackground = UIImageView(frame: CGRect(x: width / 4,
                                                            y: height / 4,
                                                            width: width / 2,
                                                            height: height / 2))
        
        imageViewBackground.image = UIImage(named: "noOrder")?.withTintColor(.lightGray)
        imageViewBackground.contentMode = .scaleAspectFit
        imageViewBackground.contentScaleFactor = 0.5
        
        backgroundView.addSubview(label)
        backgroundView.addSubview(imageViewBackground)
        
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
    }
}


