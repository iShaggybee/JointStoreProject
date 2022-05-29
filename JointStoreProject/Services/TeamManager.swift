//
//  TeamManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 29.05.2022.
//

class TeamManager {
    static let shared = TeamManager()
    
    let team = [
        Person(name: "Вадим", surname: "Кислов"),
        Person(name: "Павел", surname: "Безбородов"),
        Person(name: "Андрей", surname: "Барсук"),
        Person(name: "Игорь", surname: "Богданов"),
        Person(name: "Борис", surname: "Павлов")
    ]
    
    private init() {}
}
