//
//  MyCEFRApp.swift
//  MyCEFR
//
//  Created by Лаборатория on 21.04.2023.
//

import SwiftUI

@main
struct MyCEFRApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Coordinator())
        }
    }

}


