//
//  ButtonImageViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import Foundation

class ButtonImageViewModel: ObservableObject {

    let imageSystemName: String
    var completion: (()->())!

    init(imageSystemName: String) {
        self.imageSystemName = imageSystemName
    }

    func setupAction(completion: @escaping ()->()) {
        self.completion = completion
    }

}
