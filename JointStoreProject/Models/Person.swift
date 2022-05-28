//
//  Person.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 28.05.2022.
//

struct Person {
    let name: String
    let surname: String
    
    func getFullName() -> String {
        "\(surname) \(name)"
    }
}
