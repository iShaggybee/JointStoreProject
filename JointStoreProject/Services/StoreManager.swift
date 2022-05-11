//
//  StoreManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

protocol StoreManagerDelegateProtocol {
    func increaseCountProduct(name: String, by count: Int)
    func reduceCountProduct(name: String, by count: Int)
    func changeCountProduct(name: String, by count: Int)
}

class StoreManager {
    static let shared = StoreManager()
    
    private var products: [ProductItem] = []
    
    private init() {}
    
    func getProducts() -> [ProductItem] {
        products
    }
    
    func addProduct(name: String, description: String, count: Int) {
        products.append(getProductItem(name: name, description: description, count: count))
    }
    
    func editProduct(forIndex index: Int, name: String, description: String, count: Int) {
        let productItem = products[index]
        
        productItem.count = count
        productItem.product.name = name
        productItem.product.description = description
    }
    
    private func getProductItem(name: String, description: String, count: Int) -> ProductItem {
        ProductItem(product: getProduct(name: name, description: description), count: count)
    }
    
    private func getProduct(name: String, description: String) -> Product {
        Product(name: name, description: description)
    }
}

extension StoreManager: StoreManagerDelegateProtocol {
    func increaseCountProduct(name: String, by count: Int) {
        guard let productItem = products.first(where: { $0.product.name == name }) else {
            return
        }
        
        productItem.count += count
    }
    
    func reduceCountProduct(name: String, by count: Int) {
        guard let productItem = products.first(where: { $0.product.name == name }) else {
            return
        }
        
        productItem.count -= count
    }
    
    func changeCountProduct(name: String, by count: Int) {
        guard let productItem = products.first(where: { $0.product.name == name }) else {
            return
        }
        
        productItem.count = count
    }
}
