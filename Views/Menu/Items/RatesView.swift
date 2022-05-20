//
//  RatesView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI

struct RatesView: View {
    var body: some View {
        ZStack {
            
        Image("rates")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .navigationTitle("Тарифы")
        .navigationBarTitleDisplayMode(.large)
        
    }
}

struct RatesView_Previews: PreviewProvider {
    static var previews: some View {
        RatesView()
    }
}
