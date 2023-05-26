//
//  ButtonViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import Foundation

class ButtonViewModel: ObservableObject {

    let buttonText: String
    var completion: (()->())!

    init(buttonText: String) {
        self.buttonText = buttonText
    }

    func setupAction(completion: @escaping ()->()) {
        self.completion = completion
    }
    
}
