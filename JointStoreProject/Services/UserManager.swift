//
//  UserManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class UserManager {
    static let shared = UserManager()
    
    let users = [
        User(login: "client", password: "qwerty", type: .client),
        User(login: "employee", password: "qwerty", type: .employee)
    ]
    
    private init() {}
}
