//
//  VPNApp.swift
//  VPN
//
//  Created by Sergey on 13.04.2022.
//

import SwiftUI

@main
struct VPNApp: App {
    let persistenceController = PersistenceController.shared
@StateObject var matrixThemeToggle = MainModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(matrixThemeToggle)
        }
    }
}
