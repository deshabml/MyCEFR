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
    @Published var image = PhotoPickerViewModel()
    @Published var showAllertError = false
    @Published var isShowEditScreen = false
    @Published var progressUploadPhotosCPVM = CircularProgressViewModel()

    
    var completion: (()->())!
    var allertTextError = "theSizeOfThePhotoShouldNotExceedTwoMB".localized
    
    init() {
        cancelButtonVM.setupAction { [unowned self] in
            self.bindingPropertySetup()
            self.image.resetSettings()
            self.dismissScreen()
        }
        saveButtonVM.setupAction { [unowned self] in
            self.editProfile()
            if self.uploadPhotos() {
                self.dismissScreen()
            }
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
        self.completion()
    }
    
    func uploadPhotos() -> Bool {
        if let dataImage = image.loadedImage?.data {
            guard dataImage.count <= 2000000 else {
                showAllertError.toggle()
                return false
            }
            DispatchQueue.main.async { [unowned self] in
                StorageService.shared.uploadPhotos(image: dataImage, imageUrl: self.userProfile.imageUrl) { [unowned self] in
                    self.completion()
                    self.progressUploadPhotosCPVM.setup(progress: 0)
                } completionProgress: { [unowned self] progress in
                    if progress <= 1 {
                        self.progressUploadPhotosCPVM.setup(progress: progress)
                        print(self.progressUploadPhotosCPVM.progress)
//                        print(6.0642653933467096e-05 <= 1 ? "Yes" : "No")
                    }
                }
            }
            return true
        } else {
            return false
        }
    }
    
    func bindingPropertySetup() {
        if userProfile.name != "Имя и Фамилия", userProfile.name != "First and last name" {
            nameTFVM.setupProperty(userProfile.name)
            number = "\(userProfile.phone)"
        }
    }
    
}
