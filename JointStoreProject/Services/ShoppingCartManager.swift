//
//  ShoppingCart.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class ShoppingCartManager {
    static let shared = ShoppingCartManager()
    
    var storeManagerDelegate = StoreManager.shared as StoreManagerDelegateProtocol
    var orderManagerDelegate = OrderManager.shared as OrderManagerDelegateProtocol
    
    private var products: [ProductItem] = []
    
    private init() {}
    
    func getProducts() -> [ProductItem] {
        products
    }
    
    func addProduct(name: String, description: String, count: Int) {
        products.append(getProductItem(name: name, description: description, count: count))
        
        storeManagerDelegate.reduceCountProduct(name: name, by: count)
    }
    
    func removeProduct(index: Int) {
        let item = products.remove(at: index)
        
        storeManagerDelegate.increaseCountProduct(name: item.product.name, by: item.count)
    }
    
    func changeCountProduct(index: Int, count: Int) {
        let item = products[index]
        
        item.count = count
        
        storeManagerDelegate.changeCountProduct(name: item.product.name, by: count)
    }
    
    func createOrder() {
        orderManagerDelegate.createOrder(products: products, number: Int.random(in: 1000000..<999999))
        
        products.removeAll()
    }
    
    func clearShoppingCart() {
        for item in products {
            storeManagerDelegate.increaseCountProduct(name: item.product.name, by: item.count)
        }
        
        products.removeAll()
    }
    
    private func getProductItem(name: String, description: String, count: Int) -> ProductItem {
        ProductItem(product: getProduct(name: name, description: description), count: count)
    }
    
    private func getProduct(name: String, description: String) -> Product {
        Product(name: name, description: description)
    }
}
