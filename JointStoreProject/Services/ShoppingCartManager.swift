//
//  ShoppingCart.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class ShoppingCartManager {
    static let shared = ShoppingCartManager()
    
    var storeManager = StoreManager.shared
    var orderManager = OrderManager.shared
    
    private var products: [ProductItem] = []
    
    private init() {}
    
    func getProducts() -> [ProductItem] {
        products
    }
    
    func addProductItem(product: Product, count: Int) {
        if let productItem = products.first(where: { $0.product.name == product.name }) {
            productItem.count += count
        } else {
            products.append(getProductItem(product: product, count: count))
        }
        
        storeManager.reduceCountProduct(name: product.name, by: count)
    }
    
    func removeProductItem(product: Product) {
        guard let index = products.firstIndex(where: { $0.product.name == product.name }) else { return }
        
        let item = products.remove(at: index)
        
        storeManager.increaseCountProduct(name: item.product.name, by: item.count)
    }
    
    func changeCountOf(productItem: ProductItem, count: Int) {
        guard let item = products.first(where: { $0.product.name == productItem.product.name }) else {
            return
        }
        
        item.count = count
        
        storeManager.changeCountProduct(name: item.product.name, by: count)
    }
    
    func createOrder() {
        orderManager.createOrder(products: products, number: Int.random(in: 1000000..<999999))
        
        products.removeAll()
    }
    
    func clearShoppingCart() {
        for item in products {
            storeManager.increaseCountProduct(name: item.product.name, by: item.count)
        }
        
        products.removeAll()
    }
    
    private func getProductItem(product: Product, count: Int) -> ProductItem {
        ProductItem(product: product, count: count)
    }
}
