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

    func signIn(login: String, password: String) async throws -> User {
        do {
            let result = try await auth.signIn(withEmail: login, password: password)
            return result.user
        } catch { throw error }
    }

    func signUp(login: String, password: String) async throws -> UserProfile {
        do {
            let result = try await auth.createUser(withEmail: login,
                                                   password: password)
            let user = result.user
            let userProfile = UserProfile(id: user.uid,
                                          name: "First and last name",
                                          eMail: user.email ?? "",
                                          phone: 0,
                                          imageUrl: "UserImage/deshabImage.jpg")
            do {
                try await FirestoreService.shared.createProfile(userProfile: userProfile)
                return userProfile
            } catch { throw error }
        } catch { throw error }
    }

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

    func signOut() throws {
        do {
            try auth.signOut()
        } catch { throw error }
    }

}
