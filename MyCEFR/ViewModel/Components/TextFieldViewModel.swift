//
//  TextFieldViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation

class TextFieldViewModel: ObservableObject {

    @Published var bindingProperty: String = "" {
        didSet {
            completion()
        }
    }
    @Published var showError = false
    let placeHolder: String
    var completion: (()->())!

    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }

    func setupDidSet(completion: @escaping ()->()) {
        self.completion = completion
    }

    func clear() {
        bindingProperty = ""
    }

    func showErrorToggle() {
        showError.toggle()
    }

}
