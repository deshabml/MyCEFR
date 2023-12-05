//
//  MainView.swift
//  MyCEFR
//
//  Created by Лаборатория on 13.09.2023.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
            mainView
            .animation(.easeInOut(duration: 0.4), value: coordinator.isUser)
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
            .environmentObject(Coordinator(isWorker: false))
    }
}

extension MainView {

    private var mainView: some View {
        VStack {
            if coordinator.isUser {
                ZStack {
                    TabView(selection: $coordinator.tab) {
                        tabItem(myPage: .selectLevel,
                                image: Image(systemName: "house.fill"),
                                myTab: .home,
                                path: $coordinator.pathHome)
                        tabItem(myPage: .level,
                                    image: Image("CurrentCourseImage"),
                                    myTab: .currentCourse,
                                    path: $coordinator.pathCurrentCourse)
                        tabItem(myPage: .profileSettings,
                                image: Image(systemName: "person.fill"),
                                myTab: .profile,
                                path: $coordinator.pathProfile)
                    }
                    if coordinator.isShowTabBar {
                        VStack {
                            Spacer()
                            HStack {
                                HStack (spacing: 10) {
                                    tabButton(image: Image(systemName: "house.fill"),
                                              myTab: .home)
                                    if coordinator.isShowCurrentCourse {
                                        tabButton(image: Image("CurrentCourseImage"),
                                                  myTab: .currentCourse)
                                    }
                                    tabButton(image: Image(systemName: "person.fill"),
                                              myTab: .profile)
                                }
                                .frame(height: 90)
                                .padding(.horizontal, 30)
                                .background(.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 12)
                        }
                    }
                }
                .ignoresSafeArea()
            } else {
                AuthorizationView(viewModel: AuthorizationViewModel())
                    .environmentObject(coordinator)
            }
        }
        .preferredColorScheme(.light)
        .animation(.easeInOut(duration: 0.2),
                   value: coordinator.isShowCurrentCourse)
        .animation(.easeInOut(duration: 0.2),
                   value: coordinator.isShowTabBar)
    }

    @ViewBuilder
    private func tabItem(myPage: MyPage,image: Image, myTab: MyTab, path: Binding<NavigationPath>) -> some View {
        NavigationStack(path: path) {
            coordinator.getPage(myPage)
                .navigationDestination(for: MyPage.self) { page in
                    coordinator.getPage(page)
                }
        }
        .tag(myTab)
    }

    @ViewBuilder
    private func tabButton(image: Image, myTab: MyTab) -> some View {
        Button {
            coordinator.tab = myTab
        } label: {
            VStack {
                image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle((coordinator.tab == myTab) ? Color("MainBlueColor") : .gray)
                    .frame(width: (coordinator.tab == myTab) ? 40 : 30,
                           height: (coordinator.tab == myTab) ? 40 : 30)
                Text(myTab.rawValue.localized)
                    .font(Font.custom("Spectral", size: 12)
                        .weight(.medium))
                    .foregroundStyle((coordinator.tab == myTab) ? .black : .gray)
            }
        }
    }
}
