//
//  ContentViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import Foundation

class ContentViewModel: ObservableObject {

    @Published var currentUser = AuthService.shared.currentUser

    // MARK: - Присваиваем currentUser актуальную информацию о пользователе
    func updatingUser() {
        currentUser = AuthService.shared.currentUser
    }

}
