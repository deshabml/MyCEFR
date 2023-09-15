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
                TabView(selection: $coordinator.tab) {
                    tabItem(myPage: .selectLevel,
                            imageName: "house.fill",
                            myTab: .home)
                    tabItem(myPage: .profileSettings,
                            imageName: "person.fill",
                            myTab: .profile)
                }
            } else {
                AuthorizationView(viewModel: AuthorizationViewModel())
                    .environmentObject(coordinator)
            }
        }
        .preferredColorScheme(.light)
    }

    private func tabItem(myPage: MyPage,imageName: String, myTab: MyTab) -> some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(myPage)
                .navigationDestination(for: MyPage.self) { page in
                    coordinator.getPage(page)
                }
        }
        .tabItem {
            Image(systemName: imageName)
                .frame(width: 30, height: 30)
        }
        .tag(myTab)
    }

}
