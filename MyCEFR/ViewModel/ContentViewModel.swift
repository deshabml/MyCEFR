//
//  ContentViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import Foundation

class ContentViewModel: ObservableObject {

    var psvm = ProfileSettingsViewModel()

    var isLoggedIn: Bool {
        if let currentUser = AuthService.shared.currentUser {
            psvm.setupUser(user: UserProfile(eMail: currentUser.email ?? ""))
            return true
        } else {
            return false
        }
    }
    
}
