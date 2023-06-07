//
//  ProfileSettingsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import UIKit

class ProfileSettingsViewModel: ObservableObject {

    let contentViewModel: ContentViewModel
    @Published var userProfile = UserProfile(name: "First and last name",
                                             eMail: "adress@email.ru",
                                             phone: 88888888888,
                                             imageUrl: "")
    @Published var buttonExitVM = ButtonViewModel(buttonText: "log out")
    @Published var image: UIImage?

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
        guard let user = contentViewModel.currentUser else { return }
        Task {
            do {
                let userProfile = try await  FirestoreService.shared.getProfile(userId: user.uid)
                DispatchQueue.main.async { [unowned self] in
                    self.userProfile = userProfile
                    self.getImage()
                }
            } catch {
                print(error)
            }
        }
    }

    func getImage() {
        print(userProfile.imageUrl)
        StorageService.shared.getImage(imageUrl: userProfile.imageUrl) { result in
            switch result {
                case .success(let image):
                    self.image = image
                case .failure(let error):
                    print(error)
            }
        }
    }

}
