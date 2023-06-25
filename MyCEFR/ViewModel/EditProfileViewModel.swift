//
//  EditProfileViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {

    @Published var showScreenEditProfile = ShowScreenEPViewModel(imageName: "WhiteBackground")
    @Published var userProfile = UserProfile(name: "First and last name",
                                             eMail: "adress@email.ru",
                                             phone: 88888888888,
                                             imageUrl: "")
    @Published var cancelButtonVM = ButtonViewModel(buttonText: "сancel".localized)
    @Published var saveButtonVM = ButtonViewModel(buttonText: "save".localized)

    @Published var nameTFVM = TextFieldViewModel(placeHolder: "")
    @Published var number = ""
    @Published var image = PhotoPickerRecipeViewModel()

    init() {
        cancelButtonVM.setupAction { [unowned self] in
            self.dismissScreen()
        }
        saveButtonVM.setupAction { [unowned self] in
            print("Save")
        }
        nameTFVM.setupProperty(userProfile.name)
        number = "\(userProfile.phone)"

    }

    func dismissScreen() {
        showScreenEditProfile.isShow.toggle()
    }

    func setUserProfile(userProfile: UserProfile) {
        self.userProfile = userProfile
    }

}
