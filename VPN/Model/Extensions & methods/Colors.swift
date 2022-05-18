//
//  Colors.swift
//  VPN
//
//  Created by Sergey on 16.04.2022.
//


import SwiftUI


extension Color {
    public static let powerButtonColor = Color(UIColor(red: 161.0/255.0, green: 87.0/255.0, blue: 255.0/255.0, alpha: 0.55))
    
    public static let powerButtonColorMatrix = Color(UIColor(red: 3.0/255.0, green: 160.0/255.0, blue: 98.0/255.0, alpha: 0.35))
    
    public static let gradientButtonColor = RadialGradient(gradient: .powerButtonGradient, center: .center, startRadius: 5, endRadius: 120)
    
//    public static let customCapacity = 
}




extension Gradient {
    public static let powerButtonGradient = Gradient(colors: [Color(UIColor(.powerButtonColor)), Color(UIColor(.white))])
    
    public static let powerButtonGradientMatrix = Gradient(colors: [Color(UIColor(.powerButtonColorMatrix)), Color(UIColor(.white))])
    
    public static let defaultButtonGradient = Gradient(colors: [Color(UIColor(.black)), Color(UIColor(.gray))])
    
    public static let ringConnectionGradient = Gradient(colors: [Color(UIColor(.black)), Color(UIColor(.purple))])
    
    public static let brandGradient = Gradient(colors: [Color(.systemTeal), Color(.systemPurple)])
    
    
}

extension RadialGradient {
    
    public static let connectedButtonColor = RadialGradient(gradient: .powerButtonGradient, center: .center, startRadius: 5, endRadius: 300)
    
    public static let disconnectedButtonColor = RadialGradient(gradient: .defaultButtonGradient, center: .center, startRadius: 5, endRadius: 200)
    
    public static let connectedMatrixButtonColor = RadialGradient(gradient: .powerButtonGradientMatrix, center: .center, startRadius: 5, endRadius: 300)
}
