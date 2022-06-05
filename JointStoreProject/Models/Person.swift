//
//  Person.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 28.05.2022.
//

import UIKit

struct Person {
    let name: String
    let surname: String

    func getFullName() -> String {
        "\(name) \(surname)"
    }
}
