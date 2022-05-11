//
//  User.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//
enum UserType {
    case client
    case employee
}

struct User {
    let login: String
    let password: String
    let type: UserType
}
