//
//  BackgroundElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import SwiftUI

struct AuthBackgroundElement: ViewModifier {

    @Binding var isShowView: Bool
    var headingText: String
    var ImageName: String

    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(ImageName)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .blur(radius: isShowView ? 0 : 12)
                    .overlay(alignment: .bottom, content: {
                        Ellipse()
                            .foregroundColor(Color("MainBlueColor"))
                            .frame(width: 570, height: 492)
                            .padding(.bottom, 650)
                    })
                    .overlay(alignment: .top, content: {
                        Text(headingText)
                            .modifier(TextElement(size: 28,
                                                  verticalPadding: 100,
                                                  foregroundColor: .white))
                    })
            )
    }

}
