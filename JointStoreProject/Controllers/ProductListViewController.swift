//
//  ProductListViewController.swift
//  JointStoreProject
//
//  Created by Андрей Барсук on 18.05.2022.
//

import UIKit

class ProductListViewController: UITableViewController {
    @IBOutlet var backToFullListButton: UIBarButtonItem!
    
    var delegate: LinkingTabBarViewController!
    
    private var storeManager = StoreManager.shared
    private let shoppingCartManager = ShoppingCartManager.shared
    private var products = StoreManager.shared.products
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backToFullListButton.tintColor = UIColor.clear
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        showSearchAlert()
    }
    @IBAction func backToFullListButtonPressed(_ sender: Any) {
        products = storeManager.products
        navigationItem.title = "Каталог"
        backToFullListButton.tintColor = UIColor.clear
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        
        cell.selectionStyle = .none
        cell.productImageView.image = UIImage(named: product.name)
        cell.productNameLabel.text = product.name
        cell.productDescriptionLabel.text = product.description
        cell.productPriceLabel.text = "\(product.price) ₽"
        cell.addToCart = {
            self.shoppingCartManager.addProductItem(product: product, count: 1)
            self.showAddedToCartAlert(product)
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let productVC = segue.destination as? ProductViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let product = products[indexPath.row]
        
        productVC.product = product
        productVC.delegate = delegate
    }
    
}

extension UITextField {
    func setOnTextChangeListener(onTextChanged :@escaping () -> Void){
        self.addAction(UIAction(){ action in
            
            onTextChanged()
            
        }, for: .editingChanged)
    }
}

extension ProductListViewController {
    func showAddedToCartAlert(_ product: Product) {
        let title = "Добавлено"
        let message = "Продукт '\(product.name)' добавлен в корзину. Продолжить покупки или перейти к корзине?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let backToStoreAction = UIAlertAction(title: "Продолжить", style: .default)
        let goToCartAction = UIAlertAction(title: "Корзина", style: .default) { _ in
            self.delegate.changeTabBarItem(on: .shoppingCart)
        }
        alert.addAction(backToStoreAction)
        alert.addAction(goToCartAction)
        present(alert, animated: true)
    }
    
    func showSearchAlert() {
        let alert = UIAlertController(title: "Поиск", message: .none, preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Готово", style: .default)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            self.products = self.storeManager.products
            self.navigationItem.title = "Каталог"
            self.backToFullListButton.tintColor = UIColor.clear
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        alert.addTextField(configurationHandler: { (textField: UITextField) in
            textField.delegate = self
            textField.clearButtonMode = .whileEditing
            textField.returnKeyType = .done
            textField.setOnTextChangeListener {
                if (textField.text ?? "").isEmpty {
                    self.products = self.storeManager.products
                    self.navigationItem.title = "Каталог"
                    self.backToFullListButton.tintColor = UIColor.clear
                } else {
                    self.products = self.storeManager.searchProducts(by: textField.text!)
                    self.navigationItem.title = "Поиск: \(textField.text!)"
                    self.backToFullListButton.tintColor = UIColor.systemBlue
                }

                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        })
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

extension ProductListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true)
        return true
    }
}
