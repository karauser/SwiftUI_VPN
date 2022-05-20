//
//  VPNApp.swift
//  VPN
//
//  Created by Sergey on 13.04.2022.
//

import SwiftUI
import Firebase

@main
struct VPNApp: App {
   
        
        //MARK: Inizialize Firebase
        
        init() {
            FirebaseApp.configure()
            
        }
    
    

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
