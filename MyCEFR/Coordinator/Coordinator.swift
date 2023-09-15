//
//  Coordinator.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.09.2023.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {

    @Published var path = NavigationPath()
    @Published var page: MyPage = .selectLevel
    @Published var tab: MyTab = MyTab.home
    @Published var isUser = false
    var currentUser = AuthService.shared.currentUser {
        didSet {
            findOutIsUser()
            downloadProfile()
        }
    }
    @Published var imegeProfile: UIImage?
    @Published var userProfile: UserProfile = UserProfile(name: "firstAndlastName".localized,
                                                          eMail: "adress@email.ru",
                                                          phone: 88888888888,
                                                          imageUrl: "")
    init() {
        findOutIsUser()
        SMTPService.shared.getSMTPSetting()
        downloadProfile()
    }

    func goHome() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .authorization:
                AuthorizationView(viewModel: AuthorizationViewModel())
            case .selectLevel:
                SelectLevelView(viewModel: SelectLevelViewModel())
            case .profileSettings:
                ProfileSettingsView(viewModel: ProfileSettingsViewModel())
        }
    }

}

extension Coordinator {

    func updatingUser() {
        currentUser = AuthService.shared.currentUser
    }

    func findOutIsUser() {
        if currentUser != nil {
            isUser = true
        } else {
            isUser = false
        }
    }

    func getProfileImage() {
        StorageService.shared.getImage(imageUrl: userProfile.imageUrl) { result in
            switch result {
                case .success(let image):
                    self.imegeProfile = image
                case .failure(let error):
                    print(error)
            }
        }
    }

    func downloadProfile() {
        guard let user = AuthService.shared.currentUser else { return }
        Task {
            do {
                let userProfile = try await  FirestoreService.shared.getProfile(userId: user.uid)
                DispatchQueue.main.async { [unowned self] in
                    self.userProfile = userProfile
                    self.getProfileImage()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
