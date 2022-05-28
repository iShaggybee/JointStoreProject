//
//  CartViewController.swift
//  JointStoreProject
//
//  Created by Павел on 15.05.2022.
//

import UIKit

class CartViewController: UITableViewController {
    var delegate: LinkingTabBarViewController!
    
    private let shoppingCartManager = ShoppingCartManager.shared
    private var cart: [ProductItem] = [] {
        didSet {
            let hidden = !cart.isEmpty
            backgroundView.isHidden = hidden
            self.navigationController?.setNavigationBarHidden(!hidden, animated: false)
        }
    }
    private var editingCell: UITableViewCell?
    private var titleFooter: String {
        let total = cart.reduce(into: 0) { partialResult, ProductItem in
            partialResult += ProductItem.getTotalPrice()
        }
        
        return cart.isEmpty ? "" : "Итого на сумму \(total) ₽"
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
        cart.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell",
                                                 for: indexPath) as! CartCell
        
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
        guard let footerView = view as? UITableViewHeaderFooterView else { return }
        
        updateFooterView(footerView: footerView)
    }

    @IBAction func trashButtonPress(_ sender: UIBarButtonItem) {
        shoppingCartManager.clearShoppingCart()
        loadData()
    }
    
    @IBAction func createOrderButtonPress() {
        shoppingCartManager.createOrder()
        
        delegate.changeTabBarItem(on: .orders)
    }
    
    @objc func stepperPress(sender: UIStepper) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let titleYes = "Удалить"
        let titleNo = "Отмена"

        if sender.value == 0 {
            showAlert(title: "Минуточку!",
                      message: "Удалить товар из корзины?",
                      titleButton: [titleYes, titleNo],
                      clouser: {
                        actionFromAlert in
                            if actionFromAlert.title == titleYes {
                                self.changeCountToZero(for: indexPath)
                                self.tableView.deleteRows(at: [indexPath], with: .middle)
                            } else {
                                sender.value = 1
                            }
                        }
            )
        } else {
            self.changeCount(for: indexPath, newCount: Int(sender.value))
        }
    }
    
    private func changeCount(for index: IndexPath, newCount: Int) {
        guard let cell = tableView.cellForRow(at: index) as? CartCell else { return }
        
        let productItem = cart[index.row]
        
        cell.countLabel.layer.add(getAnimation(positive: productItem.count < newCount), forKey: nil)
        shoppingCartManager.changeCountProduct(name: productItem.product.name, by: newCount)
        setupCell(for: cell, with: productItem)
        updateFooter()
    }

    private func changeCountToZero(for index: IndexPath) {
        let productItem = cart[index.row]
        
        shoppingCartManager.removeProductItem(product: productItem.product)
        loadData()
        updateFooter()
    }

    private func loadData() {
        cart = shoppingCartManager.getProducts()
        
        tableView.reloadData()
    }
    
    private func updateFooter() {
        guard let footerView = tableView.footerView(forSection: 0) else { return }
        
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
        cell.priceLabel.text = "\(currentProduct.price)₽/\(currentProduct.unit.rawValue)"
        cell.countLabel.text = "x \(productItem.count)"
        cell.totalLabel.text = "\(productItem.getTotalPrice()) ₽"
        
        let stepper = getStepper()
        
        stepper.value = Double(productItem.count)
        cell.editingAccessoryView = stepper
    }
    
    private func getAnimation(positive: Bool) -> CASpringAnimation {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = positive ? 1.2 : 0.8
        animation.initialVelocity = 0.5
        animation.damping = 1
        
        return animation
    }
    
    private func getStepper() -> UIStepper {
        let stepper = UIStepper()
        
        stepper.minimumValue = 0
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperPress), for: .valueChanged)
        
        let incrementImage = stepper.incrementImage(for: .normal)?.withTintColor(.systemGreen,
                                                                                 renderingMode: .alwaysOriginal)
        
        stepper.setIncrementImage(incrementImage, for: .normal)
        
        let decrementImage = stepper.decrementImage(for: .normal)?.withTintColor(.systemRed,
                                                                                 renderingMode: .alwaysOriginal)
        
        stepper.setDecrementImage(decrementImage, for: .normal)
        
        return stepper
    }
    
    private func setBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        backgroundView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height / 2))
        
        label.text = "Ваша корзина пуста"
        label.textColor = .lightGray
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.textAlignment = .center
        
        let imageViewBackground = UIImageView(frame: CGRect(x: width / 4,
                                                            y: height / 4,
                                                            width: width / 2,
                                                            height: height / 2))
        
        imageViewBackground.image = UIImage(named: "EmptyCart")?.withTintColor(.lightGray)
        imageViewBackground.contentMode = .scaleAspectFit
        imageViewBackground.contentScaleFactor = 0.5
        
        backgroundView.addSubview(label)
        backgroundView.addSubview(imageViewBackground)
        
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
    }
    
    private func showAlert(title: String, message: String, titleButton: [String], clouser: @escaping (UIAlertAction) -> ()) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        for titleButton in titleButton {
            let buttonController = UIAlertAction(title: titleButton, style: .default) { action in
                    clouser(action)
            }
            alertController.addAction(buttonController)
        }
        present(alertController, animated: true)
    }
}


