//
//  UserManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class UserManager {
    static let shared = UserManager()
    
    let users = [
        User(login: "client", password: "qwerty"),
        User(login: "employee", password: "qwerty")
    ]
    
    private init() {}
}
