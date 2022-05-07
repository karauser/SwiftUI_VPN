//
//  SwiftUIView.swift
//  VPN
//
//  Created by Sergey on 24.04.2022.
//

import SwiftUI
import WebKit
import Foundation

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        
        
    }
}

