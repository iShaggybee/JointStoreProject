//
//  ProductItem.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class ProductItem {
    var product: Product
    var count: Int
    let userIndex: Int
    
    init(product: Product, count: Int, userIndex: Int) {
        self.product = product
        self.count = count
        self.userIndex = userIndex
    }
    
    func getTotalPrice() -> Int {
        product.price * count
    }
}
