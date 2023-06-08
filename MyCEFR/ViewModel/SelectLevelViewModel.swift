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
    @Published var image: UIImage?

    init(contentViewModel: ContentViewModel) {
        self.contentViewModel = contentViewModel
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
