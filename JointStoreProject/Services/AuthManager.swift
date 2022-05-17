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
    
    /// Авторизация пользователя
    func login(login: String, password: String) -> Bool {
        guard let index = users.firstIndex(where: { $0.login == login && $0.password == password }) else {
            return false
        }
        
        currentUserIndex = index
        
        return true
    }
    
    /// Выход из аккаунта
    func logout() {
        currentUserIndex = nil
    }
    
    /// Регистрация нового пользователя
    func addUser(login: String, password: String) -> Bool {
        if let _ = users.first(where: { $0.login == login }) {
            return false
        } else {
            users.append(User(login: login, password: password))
            
            return true
        }
    }
    
    /// Получение логина и пароля пользователя "по-умолчанию"
    func getInfoOnDefaultUser() -> User {
        users[0]
    }
 
    /// Получение массива пользователей с данными
    func getUsersInfo() -> [User] {
        users
    }
    
    /// Поиск пользователя по логину
    func findUserBy(login: String) -> User? {
        users.first(where: { $0.login == login })
    }
}
