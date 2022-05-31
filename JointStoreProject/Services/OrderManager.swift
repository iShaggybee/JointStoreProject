//
//  OrderManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

import Foundation

class OrderManager {
    static let shared = OrderManager()
    
    private let authManager = AuthManager.shared
    private var orders: [Order] = []
    
    private init() {}
    
    /// Получение списка заказов для текущего авторизированного пользователя
    func getOrders() -> [Order] {
        guard let currentUserIndex = authManager.currentUserIndex else { return [] }
        
        return orders.reversed().filter { $0.userIndex == currentUserIndex }
    }
    
    /// Создание заказа
    func createOrder(products: [ProductItem]) {
        guard let currentUserIndex = authManager.currentUserIndex else { return }
        
        let number = Int.random(in: 100000..<999999)
        
        orders.append(getNewOrder(products: products,
                                  number: number,
                                  userIndex: currentUserIndex))
    }
    
    private func getNewOrder(products: [ProductItem], number: Int, userIndex: Int) -> Order {
        let date = Date.now.formatted(date: .abbreviated, time: .shortened)
        
        let totalPrice = products.reduce(0, { $0 + $1.getTotalPrice() })
        
        return Order(items: products,
                     number: number,
                     date: date,
                     totalPrice: totalPrice,
                     userIndex: userIndex)
    }
}
