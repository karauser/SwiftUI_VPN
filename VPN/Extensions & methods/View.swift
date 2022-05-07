//
//  View.swift
//  VPN
//
//  Created by Sergey on 17.04.2022.
//

import UIKit
import SwiftUI

//get Screen size and frame

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first
                as? UIWindowScene else {
                    return .zero
                }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
   
}
