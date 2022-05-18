//
//  UserAgreementView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI

struct UserAgreementView: View {
    
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
    }
}
struct UserAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        UserAgreementView()
    }
}
