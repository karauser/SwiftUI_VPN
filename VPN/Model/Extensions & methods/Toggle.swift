//
//  MainModel.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import Foundation
import SwiftUI


final class MainModel: ObservableObject {
    
    @Published var matrixThemeToggle: Bool = false
    @AppStorage("current_rate") var currentRate = ""
    @AppStorage("url") var urlString: String = "https://ru.wikipedia.org/wiki/VPN"
    
    //Rates
    enum Rates: String {
      case promo = "Промо"
      case standart = "Стандарт"
      case plus = "Плюс"
    }
    //

}
