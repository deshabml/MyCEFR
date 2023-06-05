//
//  ButtonViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import Foundation

class ButtonViewModel: ObservableObject {

    let buttonText: String
    var action: (()->())!

    init(buttonText: String) {
        self.buttonText = buttonText
    }

    func setupAction(action: @escaping ()->()) {
        self.action = action
    }
    
}
