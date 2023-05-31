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
    @Published var showPassword = false
    let placeHolder: String
    var completion: (()->())!

    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }

//    func setupProperty(_ bindingProperty: String) {
//        self.bindingProperty = bindingProperty
//    }

    func setupDidSet(completion: @escaping ()->()) {
        self.completion = completion
    }

    func clear() {
        bindingProperty = ""
    }

}
