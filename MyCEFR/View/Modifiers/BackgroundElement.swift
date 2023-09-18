//
//  BackgroundElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct BackgroundElement: ViewModifier {

    @EnvironmentObject var coordinator: Coordinator
    var isProfile = false
    var headingText: String

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    VStack {
                        Color("WhiteColor")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    VStack (alignment: .center) {
                        if isProfile {
                            Rectangle()
                                .foregroundColor(Color("MainBlueColor"))
                                .frame(width: 570, height: 492)
                        } else {


                            Ellipse()
                                .foregroundColor(Color("MainBlueColor"))
                                .frame(width: 570, height: 492)
                        }
                        Spacer()
                    }
                    .padding(.top, isProfile ? -410 : -380)
                    VStack (alignment: .center) {
                        Text(headingText)
                            .modifier(TextElement(size: 28,
                                                  verticalPadding: isProfile ? 20 : 40,
                                                  foregroundColor: .white))
                        Spacer()
                    }
                })
    }

}
