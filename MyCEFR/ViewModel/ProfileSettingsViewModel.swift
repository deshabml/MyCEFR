//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import Foundation

class ProfileSettingsViewModel: ObservableObject {

    let contentViewModel: ContentViewModel
    private var user: UserProfile = UserProfile(eMail: "")
    @Published var email = ""
    @Published var buttonExitVM = ButtonViewModel(buttonText: "Выход")

    init(contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
        self.buttonExitVM.setupAction {
            do {
                try AuthService.shared.signOut()
                self.contentViewModel.updatingUser()
            } catch {
                print(error)
            }
        }
        user = UserProfile(eMail: contentViewModel.currentUser?.email ?? "")
    }

    func setupUser(user: UserProfile) {
        self.user = user
        email = user.eMail
    }

}
