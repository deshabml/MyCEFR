//
//  BackgroundElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct BackgroundElement: ViewModifier {

    var isProfile = false
    var headingText: String

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("WhiteBackground")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .overlay(alignment: .bottom, content: {
                        if isProfile {
                            Rectangle()
                                .foregroundColor(Color("MainBlueColor"))
                                .frame(width: 570, height: 492)
                                .padding(.bottom, 600)
                        } else {
                            Ellipse()
                                .foregroundColor(Color("MainBlueColor"))
                                .frame(width: 570, height: 492)
                                .padding(.bottom, 550)
                        }
                    })
                    .overlay(alignment: .top, content: {
                        Text(headingText)
                            .modifier(TextElement(size: isProfile ? 38 : 28,
                                                  verticalPadding: isProfile ? 50 : 80,
                                                  foregroundColor: .white))
                    })
            )
    }

}
