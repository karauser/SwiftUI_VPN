//
//  SideMenu.swift
//  MenuProject
//
//  Created by Sergey on 25.04.2022.
//

import SwiftUI

struct SideMenu: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var matrixThemeToggle: MainModel
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
            VStack(alignment: .leading, spacing: 15) {
                
               
                Image(matrixThemeToggle.matrixThemeToggle ? "morpheus" : "user")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                
                Text("$username")
                    .font(.title2.bold())
                
                HStack(spacing: 12) {
                    Button {
                    } label: {
                        Label {
                            Text("минус +")
                        } icon: {
                            Text("Тариф:")
                                .fontWeight(.bold)
                        }
                    }
                
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal)
            .padding(.leading)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    VStack(alignment: .leading, spacing: 45) {
                        
                                
                        //Tab buttons
                        
//                        NavigationLink(destination: Home(showMenu: $showMenu),  label: {
//                            HStack(spacing: 14) {
//                                Image(systemName: "house")
//                                    .resizable()
//                                    .renderingMode(.template)
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 22, height: 22)
//                                Text("VPN")
//                            }
//                            .foregroundColor(.primary)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        })
//                                       
                                       
                                     NavigationLink(destination: ProfileView(),  label: {
                            HStack(spacing: 14) {
                                Image(systemName: "newspaper.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                                Text("Профиль")
                            }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        
                        NavigationLink(destination: RatesView(),  label: {
                            HStack(spacing: 14) {
                                Image(systemName: "rublesign.circle")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                                Text("Тарифы")
                            }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            
                        })
                        
                            
                        
                        NavigationLink(destination: UserAgreementView(),  label: {
                            HStack(spacing: 14) {
                                Image(systemName: "newspaper.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 22, height: 22)
                                Text("Пользовательское соглашение")
                            }
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                        })
                        
                        Toggle("Matrix Theme", isOn: $matrixThemeToggle.matrixThemeToggle)
                        
                        

                    }
                        
                    .padding()
                    .padding(.leading)
                    .padding(.top, 35)
                    
                    Divider()
                    NavigationLink(destination: AuthorizationView(),  label: {
                        
                        HStack(spacing: 14) {
                            Image(systemName: "rectangle.righthalf.inset.fill.arrow.right")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 22, height: 22)
                            Text("Авторизация")
                        }
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                    })
                    
//                    tabButton(title: "Авторизация", image: "rectangle.righthalf.inset.fill.arrow.right")
                    
                    
                        .padding()
                        .padding(.leading)
                }
            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        //Max width menu
        .frame(width: UIScreen.main.bounds.width - 90)
        .frame(maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.05)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}


struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


    
