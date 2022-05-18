//
//  BaseView.swift
//  MenuProject
//
//  Created by Sergey on 25.04.2022.
//

import SwiftUI

struct BaseView: View {
    @State var showMenu: Bool = false
//Create offset for drag gesture and showing menu
    @State var offset: CGFloat               = 0
    @State var lastStoredOffset: CGFloat     = 0
//Create gesture offset
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        let sideBarWidth = getRect().width - 90
       //Navigation View
        NavigationView {
            
            HStack(spacing: 0) {
                //init side menu
                SideMenu(showMenu: $showMenu)
                //Create main tabview
                VStack(spacing: 0) {
                        HomeView(showMenu: $showMenu)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                }
                .frame(width: getRect().width)
                .overlay(
                Rectangle()
                    .fill(
                        Color.primary.opacity(Double((offset / sideBarWidth) / 5))
                        )
                            .ignoresSafeArea(.container, edges: .vertical)
                            .onTapGesture {
                                withAnimation {
                                    showMenu.toggle()
                                }
                            }
                )
            }
            .frame(width: getRect().width + sideBarWidth)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset > 0 ? offset : 0)
            
          //Add gesture reaction
            .gesture(
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded(onEndChangeGesture(value:))
            )
          //Navigation bar without title
          //Hiding navigation bar
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .animation(.easeInOut, value: offset == 0)
        .onChange(of: showMenu) { newValue in
            if showMenu && offset == 0 {
                offset = sideBarWidth
            }
            if !showMenu && offset == sideBarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) { newValue in
            onGestureChange()
        }
    }
    
    func onGestureChange() {
        let sideBarWidth = getRect().width - 90
        
        offset = (gestureOffset != 0) ? (gestureOffset + lastStoredOffset < sideBarWidth ? gestureOffset + lastStoredOffset: offset) : offset
    }
    func onEndChangeGesture(value: DragGesture.Value) {
        let sideBarWidth = getRect().width - 90
        
        let translation = value.translation.width
        withAnimation {
            //Check translation
            if translation > 0 {
                if translation > (sideBarWidth / 4) {
                    //show menu
                    offset = sideBarWidth
                    showMenu = true
                } else {
                    //1 for million case:)
                    if offset == sideBarWidth {
                        return
                    }
                offset = 0
                showMenu = false
            }
            } else {
                if -translation > (sideBarWidth / 4) {
                    offset = 0
                    showMenu = false
                } else {
                    
                    if offset == 0 || !showMenu {
                        return
                    }
                    offset = sideBarWidth
                    showMenu = true
                }
            }
            }
        lastStoredOffset = offset
    }
        
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
