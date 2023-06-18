//
//  ShowScreenSettingsElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct ShowScreenSettingsElement: ViewModifier {

    var imageName: String

    func body(content: Content) -> some View {
        content
            .background {
                Image(imageName)
            }
            .cornerRadius(18)
            .shadow(radius: 2)
            .padding()
    }

}
