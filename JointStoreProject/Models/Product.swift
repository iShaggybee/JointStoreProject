//
//  Product.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 10.05.2022.
//

enum Unit: String {
    case weight = "кг"
    case amount = "шт"
}

struct Product {
    var name: String
    var description: String
    var price: Int
    let unit: Unit
}
