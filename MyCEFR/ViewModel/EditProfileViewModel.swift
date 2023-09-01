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
    @Published var showAllertError = false
    var completion: (()->())!
    var allertTextError = "theSizeOfThePhotoShouldNotExceedTwoMB".localized

    init() {
//        self.nameTFVM.setupProperty(userProfile.name)
        cancelButtonVM.setupAction { [unowned self] in
            self.bindingPropertySetup()
            self.image.resetSettings()
            self.dismissScreen()
        }
        saveButtonVM.setupAction { [unowned self] in
            self.editProfile()
            self.uploadPhotos()
        }
        bindingPropertySetup()
    }

    func dismissScreen() {
        showScreenEditProfile.isShow.toggle()
    }

    func setUserProfile(userProfile: UserProfile) {
        self.userProfile = userProfile
    }

    func sutupCompition(completion: @escaping ()->()) {
        self.completion = completion
    }

    func editProfile() {
        guard nameTFVM.bindingProperty != "" else { return }
        userProfile.name = nameTFVM.bindingProperty
        Task {
            do {
                let _ = try await FirestoreService.shared.editProfile(userProfile: userProfile)
            } catch {
                print(error)
            }
        }
    }
    
    func uploadPhotos() {
        if let dataImage = image.loadedImage?.data {
            guard dataImage.count <= 2000000 else {
                showAllertError.toggle()
                return
            }
            DispatchQueue.main.async { [unowned self] in
                StorageService.shared.uploadPhotos(image: dataImage,
                                                   imageUrl: self.userProfile.imageUrl)
            }
            self.completion()
            self.dismissScreen()
        }
    }

    func bindingPropertySetup() {
        if userProfile.name != "Имя и Фамилия", userProfile.name != "First and last name" {
            nameTFVM.setupProperty(userProfile.name)
            number = "\(userProfile.phone)"
        }
    }

}
