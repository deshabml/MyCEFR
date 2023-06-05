//
//  TextElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import SwiftUI

struct TextElement: ViewModifier {

    var size: CGFloat
    var verticalPadding: CGFloat = CGFloat(0)
    var horizontalPadding: CGFloat = CGFloat(0)
    var foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.custom("ItimCyrillic", size: size))
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .foregroundColor(foregroundColor)
    }

}
