//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

class ProfileSettingsViewModel: ObservableObject {

    let contentViewModel: ContentViewModel
    @Published var buttonExitVM = ButtonViewModel(buttonText: "logOut".localized)
    @Published var imagePVM = ImagePrifileViewModel()
    @Published var editPVM = EditProfileViewModel()

    init(contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
        editPVM.sutupCompition { [unowned self] in
            self.getImage()
        }
        self.buttonExitVM.setupAction {
            do {
                try AuthService.shared.signOut()
                self.contentViewModel.updatingUser()
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
        guard let user = contentViewModel.currentUser else { return }
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
