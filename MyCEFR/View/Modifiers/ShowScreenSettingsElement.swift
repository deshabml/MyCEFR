//
//  ShowScreenSettingsElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct ShowScreenSettingsElement: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(18)
            .shadow(radius: 2)
            .padding()
    }
}
