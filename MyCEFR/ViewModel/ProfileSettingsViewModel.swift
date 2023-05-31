//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import Foundation

class ProfileSettingsViewModel: ObservableObject {

    private var user: UserProfile = UserProfile(eMail: "")

    @Published var email = ""
    @Published var buttonExitVM = ButtonViewModel(buttonText: "Выход")
    @Published var showAuthorizationScreen = false

    init() {
        self.buttonExitVM.setupAction { [unowned self] in
            do {
                try AuthService.shared.signOut()
                self.showAuthorizationScreen.toggle()
            } catch {
                print(error)
            }
        }
    }

    func setupUser(user: UserProfile) {
        self.user = user
        email = user.eMail
    }



}
