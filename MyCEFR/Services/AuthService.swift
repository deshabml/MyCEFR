//
//  AuthService.swift
//  MyCEFR
//
//  Created by Лаборатория on 30.05.2023.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthService {

    static let shared = AuthService()
    let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }

    private init() { }

    func signIn(login: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: login, password: password)
            return result.user
        } catch { throw error }
    }

    func signUp(login: String, password: String) async throws -> User {
        do {
            let result = try await auth.createUser(withEmail: login,
                                                   password: password)
            return result.user
        } catch { throw error }
    }

 //   func searchLogin(login: String) async throws {
//        do {
//            ref = Database.database().reference(withPath: "users")
 //           let _ = try await auth
 //       } catch { throw error }
 //   }

}
