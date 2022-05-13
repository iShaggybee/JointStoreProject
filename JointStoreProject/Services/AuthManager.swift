//
//  AuthManager.swift
//  JointStoreProject
//
//  Created by Kislov Vadim on 11.05.2022.
//

class AuthManager {
    static let shared = AuthManager()
    
    var currentUserIndex: Int? = nil
    private var users = [User(login: "client", password: "qwerty")]
    
    private init() {}
    
    func login(login: String, password: String) -> Bool {
        guard let index = users.firstIndex(where: { $0.login == login && $0.password == password }) else {
            return false
        }
        
        currentUserIndex = index
        
        return true
    }
    
    func logout() {
        currentUserIndex = nil
    }
    
    func addUser(login: String, password: String) -> Bool {
        if let _ = users.first(where: { $0.login == login }) {
            return false
        } else {
            users.append(User(login: login, password: password))
            
            return true
        }
    }
    
    func getInfoOnDefaultUser() -> User {
        users[0]
    }
 
    func getUsersInfo() -> [User] {
        users
    }
}
