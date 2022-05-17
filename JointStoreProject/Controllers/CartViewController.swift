//
//  CartViewController.swift
//  JointStoreProject
//
//  Created by Павел on 15.05.2022.
//

import UIKit

class CartViewController: UITableViewController {
    
    private let shoppingCartManager = ShoppingCartManager.shared
    var cart: [ProductItem] = []
    var editingCell: UITableViewCell?
    var titleFooter: String {
        let total = cart.reduce(into: 0) { partialResult, ProductItem in
            partialResult += ProductItem.getTotalPrice()
        }
        return "Итого на сумму \(total) рублей"
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cart.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartCell
        setupCell(for: cell, with: cart[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if let lastCell = editingCell, editingCell != cell {
            lastCell.setEditing(false, animated: true)
        }
        cell.setEditing(!cell.isEditing, animated: true)
        editingCell = cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        titleFooter
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footerView = view as? UITableViewHeaderFooterView else {return}
        updateFooterView(footerView: footerView)
    }

    @IBAction func trashButtonPress(_ sender: UIBarButtonItem) {
        shoppingCartManager.clearShoppingCart()
        loadData()
        tableView.reloadData()
    }
    @IBAction func createOrderButtonPress() {
        shoppingCartManager.createOrder()
    }
    
    @objc func stepperPress(sender:UIStepper) {
       
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let cell = tableView.cellForRow(at: indexPath) as? CartCell else { return }
        let productItem = cart[indexPath.row]
        cell.countLabel.layer.add(getAnimation(positive: productItem.count < Int(sender.value)), forKey: nil)
        shoppingCartManager.changeCountProduct(name: productItem.product.name, by: Int(sender.value))
        productItem.count = Int(sender.value) //для тестирования

        setupCell(for: cell, with: productItem)
        updateFooter()
    }
    
    private func loadData() {
        cart = shoppingCartManager.getProducts()
    }
    
    private func updateFooter() {
        
        guard let footerView = tableView.footerView(forSection: 0) else {return}
        updateFooterView(footerView: footerView)
    }
    
    private func updateFooterView(footerView: UITableViewHeaderFooterView) {
        
        var defContent = footerView.defaultContentConfiguration()
        defContent.text = titleFooter
        footerView.contentConfiguration = defContent
    }
    
    private func setupCell(for cell: CartCell, with productItem: ProductItem) {
        
        let currentProduct = productItem.product
        cell.productTitleLabel.text = currentProduct.name
        cell.priceLabel.text = String(currentProduct.price)
        cell.countLabel.text = "x \(productItem.count)"
        cell.totalLabel.text = "\(productItem.getTotalPrice()) р."
        let stepper = getStepper()
        stepper.value = Double(productItem.count)
        cell.editingAccessoryView = stepper
    }
    
    private func getAnimation(positive: Bool) -> CASpringAnimation {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.fromValue = 1
        if positive {
            animation.toValue = 1.2
        } else {
            animation.toValue = 0.8
        }
        animation.initialVelocity = 0.5
        animation.damping = 1
        return animation
    }
    
    private func getStepper() -> UIStepper {
        
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperPress), for: .valueChanged)
        let incrementImage = stepper.incrementImage(for: .normal)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        stepper.setIncrementImage(incrementImage, for: .normal)
        let decrementImage = stepper.decrementImage(for: .normal)?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        stepper.setDecrementImage(decrementImage, for: .normal)
        return stepper
    }
}
