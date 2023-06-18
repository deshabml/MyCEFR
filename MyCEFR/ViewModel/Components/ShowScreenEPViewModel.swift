//
//  ShowScreenEPViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import Foundation

class ShowScreenEPViewModel: ObservableObject {

    @Published var isShow: Bool = false
    var imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }

}
