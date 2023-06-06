//
//  TabBarView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct TabBarView: View {

    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        NavigationView {
            TabView {
                SelectLevelView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: contentViewModel))
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
        }
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
