//
//  Animation.swift
//  VPN
//
//  Created by Sergey on 16.04.2022.
//

import Foundation
import SwiftUI

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

struct TheSolution: View {
    @State var active: Bool = false
    var body: some View {
        Circle()
            .scaleEffect( active ? 1.08: 1)
//            .animation(Animation.default.repeat(while: active))
            .animation(Animation.default.repeat(while: active), value: active)
            .frame(width: 100, height: 100)
            .onTapGesture {
                self.active.toggle()
            }
    }
}

struct TheSolution_Previews: PreviewProvider {
    static var previews: some View {
        TheSolution()
    }
}
