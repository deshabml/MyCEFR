//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

class ProfileSettingsViewModel: ObservableObject {

    @Published var buttonExitVM = ButtonViewModel(buttonText: "logOut".localized)
    @Published var imagePVM = ImagePrifileViewModel()
    @Published var editPVM = EditProfileViewModel()
    var completeonUpdatingUser: (()->())!

    func setup(completeonUpdatingUser: @escaping ()->()) {
        self.completeonUpdatingUser = completeonUpdatingUser
        editPVM.sutupCompition { [unowned self] in
            self.downloadProfile()
        }
        self.buttonExitVM.setupAction {
            do {
                try AuthService.shared.signOut()
                self.completeonUpdatingUser()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getImage() {
        StorageService.shared.getImage(imageUrl: editPVM.userProfile.imageUrl) { result in
            switch result {
                case .success(let image):
                    self.imagePVM.setImage(image: image)
                    self.editPVM.image.setupImageStandard(Image(uiImage: image))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    func editUserData() {
        editPVM.showScreenEditProfile.isShow.toggle()
        guard let image = imagePVM.image else { return }
        editPVM.image.setupImageStandard(Image(uiImage: image))
    }

    func updateEditPVM() {
        editPVM = editPVM
    }

    func downloadProfile() {
        guard let user = AuthService.shared.currentUser else { return }
        Task {
            do {
                let userProfile = try await  FirestoreService.shared.getProfile(userId: user.uid)
                DispatchQueue.main.async { [unowned self] in
                    self.editPVM.setUserProfile(userProfile: userProfile)
                    self.updateEditPVM()
                    self.getImage()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
