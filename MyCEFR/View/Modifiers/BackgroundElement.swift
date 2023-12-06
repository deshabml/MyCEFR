//
//  BackgroundElement.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct BackgroundElement: ViewModifier {

    var isProfile = false
    var isBottomPading: Bool = true
    var isFirstScreen: Bool = false
    var isActionScreen: Bool = false
    var headingText: String
    var colorBack: Color?
    var completion: (()->())?

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .tabBar)
            .padding(.bottom, isBottomPading ? 80 : 0)
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
                                .foregroundColor(colorBack ?? Color("MainBlueColor"))
                                .frame(width: 570, height: 492)
                        } else {
                            Ellipse()
                                .foregroundColor(Color("MainBlueColor"))
                                .frame(width: 570, height: 510)
                        }
                        Spacer()
                    }
                    .padding(.top, isProfile ? -410 : -380)
                    if !isFirstScreen {
                        VStack {
                            HStack(alignment: .top) {
                                Button {
                                    completion?()
                                } label: {
                                    Image(systemName: isActionScreen ? "xmark" : "chevron.backward")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: isActionScreen ? 16 : 12,
                                               height: isActionScreen ? 16 : 12)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 10)
                                        .padding(.leading, 100)
                                }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    VStack (alignment: .center) {
                        Text(headingText)
                            .modifier(TextElement(size: 28,
                                                  verticalPadding: isProfile ? colorBack != nil ? 0 : 20 : 40,
                                                  foregroundColor: .white))
                        Spacer()
                    }
                })
    }
}
