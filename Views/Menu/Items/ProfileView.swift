//
//  ProfileView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    //MARK: faceID properties
    @AppStorage("use_face_id") var useFaceID = false
    @AppStorage("use_face_email") var faceIDEmail = ""
    @AppStorage("use_face_password") var FaceIDPassword = ""
    
    //Log status
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        
        ScrollView {
        VStack(spacing: 20) {
            
            if logStatus {
                
                Image("andrey")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("Андрей")
                    .font(.title2.bold())
                Image("plusrate")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Button {
                    try? Auth.auth().signOut()
                    logStatus = false
                } label: {
                    Text("Logout")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .hCener()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.red)
                    }
                }
            
            } else {
                Text("Came as guest")
            }
            
            if useFaceID {
                //Clear Face ID
                Button {
                    useFaceID = false
                    faceIDEmail = ""
                    FaceIDPassword = ""
                } label: {
                    Text("Disable Face ID")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .hCener()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.brown).opacity(0.5)
                    }
                }
            }
        }}
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.large)
    
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
