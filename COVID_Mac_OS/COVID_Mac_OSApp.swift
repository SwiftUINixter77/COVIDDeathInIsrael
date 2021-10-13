//
//  COVID_Mac_OSApp.swift
//  COVID_Mac_OS
//
//  Created by Nikolay Nikolayenko on 16/01/2021.
//

import SwiftUI

@main
struct COVID_Mac_OSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 400, height: 300, alignment: .center)
                .background(VisualEffectBackground(material: .fullScreenUI, blendingMode: .behindWindow, emphasized: true).edgesIgnoringSafeArea(.top))
                .preferredColorScheme(.dark)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
