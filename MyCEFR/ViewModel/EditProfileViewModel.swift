//
//  EditProfileViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {

    @Published var showScreenEditProfile = ShowScreenEPViewModel(imageName: "WhiteBackground")
    @Published var userProfile = UserProfile(name: "firstAndlastName".localized,
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
            self.nameTFVM.setupProperty(userProfile.name)
            self.image.resetSettings()
            self.dismissScreen()
        }
        saveButtonVM.setupAction { [unowned self] in
            if let dataImage = image.loadedImage?.data {
                print(dataImage)
            }
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
