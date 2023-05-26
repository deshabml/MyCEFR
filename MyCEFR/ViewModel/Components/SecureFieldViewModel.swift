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
    var isThereButton = false
    var placeHolder = "Password"
    var completion: (()->())!
    
//    func setupProperty(_ bindingProperty: String) {
//        self.bindingProperty = bindingProperty
//    }

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

//    func clear() {
//        bindingProperty = ""
//    }

}
