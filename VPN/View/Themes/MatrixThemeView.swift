//
//  MatrixRainView.swift
//  MatrixTheme
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI

//MARK: Make random Characters

let constant = "bchfgdyruwtqradxcnbmhofudheopgjfhu57dh3093hncjuafwouofuaevfwbuvuewpufvupanupvwaufopviufsuiovgygquip[qni[vpuwpneuiovugyioueyqwuenuvpqunwrupuvuqnuwr'eiv'iqir[iw[inrin329qu5r90q3475894nq3986tvq389bv47590v3729qn83-nv87093   8n2-57897v09q7309v57n302v707n0v5n72n7qv5nn2737nv85-8n73-58v-[382-v87-28 q8v-5283[v-982-vq58239-7v5023"

struct MatrixRainView: View {
    
  
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 15) {
                ForEach(1...(Int(size.width) / 25), id: \.self) {_ in
                    MatrixRainCharacters(size: size)
                }
                
            }
           
        }
        
    }
}

struct MatrixRainCharacters: View {
    var size: CGSize
    //MARK: Animation Properties
    @State var startAnimation = false
    @State var random = 0
    var body: some View {
        //Random Height
        let randomHeight: CGFloat = .random(in: ((size.height / 2...size.height)))
                                                 
        VStack {
            
            //MARK: Iterating String
            ForEach(0..<constant.count, id: \.self) { index in
                
                //Retrieve Character at String
                let character = Array(constant).randomElement()!
                
                Text(String(character))
                    .font(.custom("matrix code nfi", size: 25))
                    .foregroundColor(Color.green)
                
                
            }
        }
        .mask(alignment: .top) {
            Rectangle()
                .fill(
                    LinearGradient(colors: [.clear, .black.opacity(0.1),.black.opacity(0.2),.black.opacity(0.3),.black.opacity(0.4),.black.opacity(0.5),.black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: size.height / 2)
            
                .offset(y: startAnimation ? size.height : -randomHeight)
        }
        
        .onAppear() {
            //Make animation(slow down linear)
            //Make loop without reverse animation
            //Random delay
            withAnimation(.linear(duration: 5).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
        .onReceive(Timer.publish(every: 0, on: .main, in: .common).autoconnect()) { _ in
            random = Int.random(in: 0..<constant.count)
        }
    }
    
//    Changing characters by random by timer
    func getRandomIndex(index: Int) -> Int {
        // avoid out bound range index
        let max = constant.count - 1

        if (index) > max {
            if (index) < 0 { return index }
            return (index)
        } else {
                return (index)
            }
        }
    }
    
    


struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



