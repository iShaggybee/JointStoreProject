//
//  OrderManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

import Foundation

class OrderManager {
    static let shared = OrderManager()
    
    private var orders: [Order] = []
    
    private init() {}
    
    func getOrders() -> [Order] {
        orders
    }
    
    func createOrder(products: [ProductItem], number: Int) {
        orders.append(getOrder(products: products, number: number))
    }
    
    private func getOrder(products: [ProductItem], number: Int) -> Order {
        let date = Date.now.formatted(date: .long, time: .shortened)
        
        return Order(items: products, number: number, date: date)
    }
}

