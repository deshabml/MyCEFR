//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

final class ProfileSettingsViewModel: ObservableObject {

    @Published var buttonExitVM = ButtonViewModel(buttonText: "logOut".localized)

    @Published var editPVM = EditProfileViewModel()
    var completeonUpdatingUser: (()->())!

    func setup(completeonUpdatingUser: @escaping ()->()) {
        self.completeonUpdatingUser = completeonUpdatingUser
        self.buttonExitVM.setupAction {
            do {
                try AuthService.shared.signOut()
                self.completeonUpdatingUser()
            } catch {
                print(error.localizedDescription)
            }
        }
    }


    func editUserData() {
        editPVM.showScreenEditProfile.isShow.toggle()
    }
}
