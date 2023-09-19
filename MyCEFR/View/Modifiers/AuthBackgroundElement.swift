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
                ZStack {
                    VStack {
                        Color("BackgraundAuthorizationColor")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    VStack (alignment: .center) {
                        Ellipse()
                            .foregroundColor(Color("MainBlueColor"))
                            .frame(width: 570, height: 492)
                        Spacer()
                    }
                    .padding(.top, -380)
                    VStack (alignment: .center) {
                        Text(headingText)
                            .modifier(TextElement(size: 28,
                                                  verticalPadding: 40,
                                                  foregroundColor: .white))
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Rectangle()
                            .foregroundColor(Color("WhiteColor"))
                            .frame(width: 300, height: 600)
                            .rotationEffect(Angle(degrees: isShowView ? 35 : 50))
                    }
                    .padding(.trailing, -300)
                    .padding(.bottom, -250)
                }
                    .animation(.easeInOut(duration: 0.2), value: isShowView)

            )
    }
    
}
