//
//  AuthService.swift
//  MyCEFR
//
//  Created by Лаборатория on 30.05.2023.
//

import Foundation
import FirebaseAuth

class AuthService {

    static let shared = AuthService()
    let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }

    private init() { }

    // MARK: - Вход в профиль пользователя
    func signIn(login: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: login, password: password)
            return result.user
        } catch { throw error }
    }

    // MARK: - Создаём в профиль пользователя
    func signUp(login: String, password: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: login,
                                                   password: password)
            return result.user
        } catch { throw error }
    }

    // MARK: - Проверяем не занят ли логин(e-mail)
    func freeLogin(login: String) async throws -> Bool {
        do {
             let providers = try await auth.fetchSignInMethods(forEmail: login)
            if providers == ["password"] {
                return false
            } else {
                return true
            }
        } catch { throw error }
    }

    // MARK: - Выходим из аккаунта
    func signOut() throws {
        do {
            try auth.signOut()
        } catch { throw error }
    }

}
