//
//  AuthorizationView.swift
//  VPN
//
//  Created by Sergey on 28.04.2022.
//

import SwiftUI
import Firebase

struct AuthorizationView: View {
    @StateObject var loginModel = LoginViewModel()
    
    //Log status
    @AppStorage("log_status") var logStatus = false
    
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: faceID properties
    @State var useFaceID = false
    var body: some View {
        
        VStack(spacing: 20) {
            
            if logStatus {
//                presentationMode.wrappedValue.dismiss()
                Text("Logged in")

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
                .task {
                    presentationMode.wrappedValue.dismiss()
                }

                
            } else {
                ScrollView {
                VStack {
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .fill(.white)
                        .frame(width: 45, height: 45)
                        .rotationEffect(.init(degrees: -90))
                        .hLeading()
                        .offset(x: -23)
                        .padding(.bottom, 30)
                    
                    Text("Hey, \nSign in :)")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .hLeading()
                    
                    //MARK: Textfield
                    
                    TextField("Email", text: $loginModel.email)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    loginModel.email == "" ? .white.opacity(0.2) : .orange.opacity(0.5)
                                )
                        }
                        .keyboardType(.asciiCapable)
                        .textInputAutocapitalization(.never)
                        .padding(.top, 20)
                    
                    SecureField("Password", text: $loginModel.password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    loginModel.password.count > 7 ? .orange.opacity(0.5): .white.opacity(0.2)
                                )
                        }
                        .keyboardType(.asciiCapable)
                        .textInputAutocapitalization(.never)
                    
                    //MARK: ask to store login using faceID on text time
                    
                    if loginModel.getBiometricStatus() {
                        
                        Group {
                            
                            if loginModel.useFaceID {
                                
                                Button {
                                    //MARK: Do faceID action
                                    Task {
                                        do {
                                            try await loginModel.authentificateUser()
                                        }
                                        catch {
                                            loginModel.errorMessage = error.localizedDescription
                                            loginModel.showError.toggle()
                                        }
                                    }
                                } label: {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Label {
                                            Text("Use FaceID to login into your account")
                                        } icon: {
                                            Image(systemName: "faceid")
                                        }
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        
                                        Text("You can turn it off on settings")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .hLeading()

                            } else {
                                Toggle(isOn: $useFaceID) {
                                    Text("Use FaceID to Login")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.trailing, 5)
                    }
                    Button {
                        Task {
                            do {
                                try await loginModel.loginUser(useFaceID: useFaceID)
                            } catch {
                                loginModel.errorMessage = error.localizedDescription
                                loginModel.showError.toggle()
                            }
                        }
                    } label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding()
                            .hCener()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.red)
                            }
                    }
                    .padding(.vertical, 3)
                    .disabled(loginModel.email == "" || loginModel.password == "")
                    .opacity(loginModel.password.count > 7 ? 1 : 0.3)
                    
                    //                // MARK: Going home without login
        //            NavigationLink {
        //            } label: {
        //                Text("Skip")
        //                    .foregroundColor(.gray)
        //            }


                }
                }
                .submitLabel(.done)
//                .padding(.horizontal, 25)
//                .padding(.vertical)
                .alert(loginModel.errorMessage, isPresented: $loginModel.showError, actions: {
                    
                })
                
                .navigationBarHidden(false)
                
                
            }
            
        }
            }
        }
        


struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}

//MARK: Extension for UI Designing
extension View {
    
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
    func hCener() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
}
