//
//  ContentViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import Foundation

class ContentViewModel: ObservableObject {

    var currentUser = AuthService.shared.currentUser {
        didSet {
            findOutIsUser()
        }
    }
    @Published var isUser = false

    init() {
        findOutIsUser()
        SMTPService.shared.getSMTPSetting()
    }

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
