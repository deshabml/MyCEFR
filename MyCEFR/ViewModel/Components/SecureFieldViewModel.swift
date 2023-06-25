//
//  SecureFieldViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import Foundation

class SecureFieldViewModel: ObservableObject {

    @Published var bindingProperty: String = "" {
        didSet {
            completion()
            setupShowPassword()
        }
    }
    @Published var showPassword = false
    @Published var showError = false
    var isThereButton = false
    var placeHolder = "password".localized
    var completion: (()->())!

    func setupDidSet(completion: @escaping ()->()) {
        self.completion = completion
    }

    func setupThereButton(_ isThereButton: Bool) {
        self.isThereButton = isThereButton
    }

    func setupShowPassword() {
        if bindingProperty.isEmpty {
            self.showPassword = false
        }
    }

    func showErrorToggle() {
        showError.toggle()
    }

}
