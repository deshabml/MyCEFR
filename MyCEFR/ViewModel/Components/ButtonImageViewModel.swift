//
//  ButtonImageViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import Foundation

final class ButtonImageViewModel: ObservableObject {

    let imageSystemName: String
    var action: (()->())!

    init(imageSystemName: String) {
        self.imageSystemName = imageSystemName
    }

    func setupAction(action: @escaping ()->()) {
        self.action = action
    }

}
