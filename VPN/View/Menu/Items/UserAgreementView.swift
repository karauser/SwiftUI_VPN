//
//  UserAgreementView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI

struct UserAgreementView: View {
    
//        init() {
//            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
//        }
    
    var body: some View {
        ZStack {
            
    
        }
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Пользовательское").font(.headline)
                            Text("соглашение").font(.subheadline)
                        }
                    }
                }
        
//        .navigationBarTitle(Text("Пользовательское соглашение").font(.subheadline), displayMode: .large)
    }
}
struct UserAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        UserAgreementView()
    }
}
