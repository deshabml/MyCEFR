//
//  SelectLevelViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 07.06.2023.
//

import UIKit

class SelectLevelViewModel: ObservableObject {

    let contentViewModel: ContentViewModel
    @Published var userProfile = UserProfile(name: "First and last name",
                                             eMail: "adress@email.ru",
                                             phone: 88888888888,
                                             imageUrl: "")
    @Published var imagePVM = ImagePrifileViewModel()

    init(contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
    }

    func downloadProfile() {
        guard let user = contentViewModel.currentUser else { return }
        Task {
            do {
                let userProfile = try await  FirestoreService.shared.getProfile(userId: user.uid)
                DispatchQueue.main.async { [unowned self] in
                    self.userProfile = userProfile
                    self.getImage()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getImage() {
        StorageService.shared.getImage(imageUrl: userProfile.imageUrl) { result in
            switch result {
                case .success(let image):
                    self.imagePVM.setImage(image: image)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
