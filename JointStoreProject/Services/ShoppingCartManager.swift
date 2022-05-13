//
//  ShoppingCart.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class ShoppingCartManager {
    static let shared = ShoppingCartManager()
    
    var orderManager = OrderManager.shared
    
    private let authManager = AuthManager.shared
    private var products: [ProductItem] = []
    
    private init() {}
    
    func getProducts() -> [ProductItem] {
        guard let currentUserIndex = authManager.currentUserIndex else {
            return []
        }
        
        return products.filter {$0.userIndex == currentUserIndex }
    }
    
    func addProductItem(product: Product, count: Int) {
        guard let userIndex = authManager.currentUserIndex else { return }
        
        if let productItem = getProductItemBy(name: product.name) {
            productItem.count += count
        } else {
            products.append(getNewProductItem(product: product,
                                              count: count,
                                              userIndex: userIndex))
        }
    }
    
    func removeProductItem(product: Product) {
        guard let userIndex = authManager.currentUserIndex else { return }
        guard let index = products.firstIndex(where: { $0.product.name == product.name && $0.userIndex == userIndex }) else {
            return
        }
        
        products.remove(at: index)
    }
    
    func increaseCountProduct(name: String, by count: Int) {
        guard let productItem = getProductItemBy(name: name) else {
            return
        }
        
        productItem.count += count
    }
    
    func reduceCountProduct(name: String, by count: Int) {
        guard let productItem = getProductItemBy(name: name) else {
            return
        }
        
        productItem.count -= count
    }
    
    func changeCountProduct(name: String, by count: Int) {
        guard let productItem = getProductItemBy(name: name) else {
            return
        }
        
        productItem.count = count
    }
    
    func createOrder() {
        orderManager.createOrder(products: getProducts())
        
        removeProductsForUser()
    }
    
    func clearShoppingCart() {
        removeProductsForUser()
    }
    
    private func removeProductsForUser() {
        guard let userIndex = authManager.currentUserIndex else { return }
        
        for (index, product) in products.enumerated() {
            if product.userIndex == userIndex {
                products.remove(at: index)
            }
        }
    }
    
    private func getProductItemBy(name: String) -> ProductItem? {
        guard let userIndex = authManager.currentUserIndex else {
            return nil
        }
        guard let productItem = products.first(where: { $0.product.name == name && $0.userIndex == userIndex }) else {
            return nil
        }
        
        return productItem
    }
    
    private func getNewProductItem(product: Product, count: Int, userIndex: Int) -> ProductItem {
        ProductItem(product: product, count: count, userIndex: userIndex)
    }
}
