//
//  RatesView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI


struct RatesView: View {
    @AppStorage("current_rate") var currentRate = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var showAlert2 = false
    
    var body: some View {
        ZStack {
            ScrollView {
                Button {
                    showAlert.toggle()
                } label: {
                    Image("rateStandart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Хотите выбрать тариф \"\(MainModel.Rates.standart.rawValue)\"?"),
                        message: Text("Покупку можно отменить в течение 24 часов"),
                        primaryButton: .cancel(Text("Отмена"))
                            ,
                        secondaryButton: .default(
                            Text("Да"),
                            action: {currentRate = MainModel.Rates.standart.rawValue
                                presentationMode.wrappedValue.dismiss()
                            }
                        )
                    )
                }
                
                
                Button {
                    showAlert2.toggle()
                } label: {
                  Image("ratePlus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                }
                .alert(isPresented: $showAlert2) {
                    Alert(
                        title: Text("Хотите выбрать тариф \(MainModel.Rates.plus.rawValue)?"),
                        message: Text("Покупку можно отменить в течение 24 часов"),
                        primaryButton: .cancel(Text("Отмена"))
                            ,
                        secondaryButton: .default(
                            Text("Да"),
                            action: {
                                currentRate = MainModel.Rates.plus.rawValue
                                presentationMode.wrappedValue.dismiss()
                            }
                        )
                    )
                }

        
        
        }
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
