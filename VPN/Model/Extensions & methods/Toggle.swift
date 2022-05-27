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
    
    enum Rates: String {
      case promo = "Промо"
      case standart = "Стандарт"
      case plus = "Плюс"
    }
    
    func changeRate() -> String {
        currentRate = Rates.promo.rawValue
        return currentRate
    }
}
