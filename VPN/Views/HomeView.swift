//
//  Home.swift
//  VPN
//
//  Created by Sergey on 13.04.2022.
//

import SwiftUI
import UIKit
import WebKit

struct HomeView: View {
   
    @Binding var showMenu: Bool
    @EnvironmentObject var matrixThemeToggle: MainModel
    @State var selectedTab = "Home"
    @State private var animationAmount = 2.0
    @State private var currentServer: HardcodeServer = servers.first!
    @State var isWebViewShow           = false
    @State private var isRotateTop     = false
    @State private var isConnected     = false
    @State var isServerHasBeenChanged  = false
    @State private var isUserAuth      = false
    @State private var brandGradient: Gradient             = .brandGradient
    private let connectedButtonColor: RadialGradient       = .connectedButtonColor
    private let disconnectedButtonColor: RadialGradient    = .disconnectedButtonColor
    private let connectedMatrixButtonColor: RadialGradient = .connectedMatrixButtonColor
    private let urlString: String = "https://ru.wikipedia.org/wiki/VPN"
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                } label: {
                    VStack(alignment: .center, spacing: 5) {
                    Rectangle()
                            .frame(width: 30, height: 2.7)
                        .cornerRadius(4)
                       
                        .rotationEffect(
                        .degrees(isRotateTop ? 12 : 0),
                        anchor: .leading)
                
                    Rectangle()
                            .frame(width: 30, height: 2.5)
                        .cornerRadius(4)
                        
                        
                    }.onTapGesture {
                        withAnimation { showMenu.toggle() }
                    }
                    .padding()
                    
                }.opacity(!showMenu ? 1 : 0)
                
                Spacer()
                
                Button {isWebViewShow.toggle()} label: {
                    Image("Logo")
                        .resizable()
                        .frame(width: 60.0, height: 9.0)
                        .font(.title2)
                        .padding(12)
                        
                            .sheet(isPresented: $isWebViewShow) {
                                WebView(url: URL(string: urlString)!)
                            }
                        
                }.padding()
            }.opacity(!showMenu ? 1 : 0)
            
            .foregroundColor(.white)
            // PowerButton inizialize
            Button {
                
            } label: {
                Image(systemName: "power")
                    .font(.system(size: 45, weight: .regular))
                    .foregroundColor(isConnected ? .white : .gray)
                    .clipShape(Circle())
                    .overlay(
                        (!showMenu && isConnected) ? Pulser() : nil
                    )
                    .onTapGesture {
                        self.isConnected.toggle()
                        
                        VPNIKEv2Setup.connectVPN()
                        
                    }
        }
            // Frame
            .frame(width: 130, height: 130)
            .background(
            ZStack {
                Circle()
                    .fill(
                        isConnected && matrixThemeToggle.matrixThemeToggle ? connectedMatrixButtonColor : isConnected ? connectedButtonColor : disconnectedButtonColor
                    )
})
            .padding(.top, getRect().height / 4)
    }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background((matrixThemeToggle.matrixThemeToggle && !showMenu && isConnected) ? MatrixRainView() : nil)
            .background(
            LinearGradient(colors: [
                .black, .black
            ], startPoint: .top, endPoint: .bottom))
        //Blur effect
            .overlay(
            Rectangle()
                .fill(.ultraThinMaterial)
                .opacity(isServerHasBeenChanged ? 1 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isServerHasBeenChanged.toggle()
                    }
                }
            )
            .overlay(BottomSheetBeta(),
                     alignment: .bottom
            )
            .ignoresSafeArea(.container, edges: .bottom)
            .preferredColorScheme(.dark)
    }
   
    
//Bottom Sheet

@ViewBuilder
    func BottomSheetBeta() -> some View {
            
        VStack(spacing: 0) {
                
                //Current server
                
            HStack {
                
                Image(currentServer.flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(currentServer.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(isConnected ? "Currently connected" : "Selected")
                        .font(.caption2.bold())
                    
                }
                
                Spacer(minLength: 10)
                
                //Change server button
                
                Button {
                    withAnimation {
                        isServerHasBeenChanged.toggle()
                    }
                } label: {
                    Text(isServerHasBeenChanged ? "Закрыть" : "Изменить")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(width: 110, height: 45)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.white.opacity(0.25), lineWidth: 2)
                        )
                        .foregroundColor(.white)
                }
                
            }
            .frame(height: 50)
            .padding(.horizontal)
            
            Divider()
                .padding(.top)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 18) {
                    
                    //Filtered servers without selected one
                    
                    ForEach(servers.filter {
                        $0.id != currentServer.id
                    }){ server in
                        VStack(spacing: 12) {
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Image(server.flag)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                        Text(server.name)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                        
                                    }
                                    
                                    Label {
                                        Text("Avialable, \(server.ping)ms")
                                    } icon: {
                                        Image(systemName: "checkmark")
                                    }
                                    .foregroundColor(.green)
                                    .font(.caption2)
                                }
                                
                                
                                Spacer(minLength: 10)
                                
                                //Change server button
                                
                                Button {
                                    withAnimation {
                                        isServerHasBeenChanged.toggle()
                                        currentServer = server
                                        isConnected = false
                                    }
                                } label: {
                                    Text("Выбрать")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .frame(width: 110, height: 45)
                                        .background(
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(.white.opacity(0.25), lineWidth: 2)
                                        )
                                        .foregroundColor(.white)
                                }
                                
                            }
                            .frame(height: 50)
                            .padding(.horizontal)
                            
                            Divider()
                        }
                    }
                }
                .padding(.top, 25)
                .padding(.bottom, getSafeArea().bottom)
            }
            
            }
            .padding()
            .padding(.top, 10)
            .frame(maxWidth: .infinity)
            .frame(height: getRect().height / 2.5, alignment: .top)
            .background(
            
                Color(.black)
                    .clipShape(CustomCorners(radius: 35, corners: [.topLeft,.topRight]))
            )
            //Safe area won't show on preview
            //Show only 50 pixels of height
            .offset(y: isServerHasBeenChanged ? 0 : (getRect().height / 2.5) - (getRect().height < 750 ? 120 : 60 + getSafeArea().bottom))
        }


struct Pulser: View {

    @State var animate         = false
    @State var timeRemaining   = 2
    @State var animationAmount = 1.0
    @EnvironmentObject var matrixThemeToggle: MainModel
    
    var body: some View {
        let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

        ZStack {

            if matrixThemeToggle.matrixThemeToggle {
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 750, height: 750).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 450, height: 450).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 350, height: 350).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 250, height: 250).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 150, height: 150).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.green.opacity(Double(timeRemaining))).frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
            } else {
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 750, height: 750).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 450, height: 450).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 350, height: 350).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 250, height: 250).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 150, height: 150).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
                Circle().fill(Color.purple.opacity(Double(timeRemaining))).frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0).opacity(0.2)
            }
        }.onAppear {
            self.animate.toggle()
        }.onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }.animation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false))
    }
 }
}
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
