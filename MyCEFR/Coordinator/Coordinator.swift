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
        }
    }

    init() {
        findOutIsUser()
        SMTPService.shared.getSMTPSetting()
    }

    func goHome() {
        path.removeLast(path.count)
    }
//    func goToAuthorization() {
//        path.append(MyPage.authorization)
//    }
//    func goToSelectLevel() {
//        path.append(MyPage.selectLevel)
//    }
//    func goToProfileSettings() {
//        path.append(MyPage.profileSettings)
//    }
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

}
