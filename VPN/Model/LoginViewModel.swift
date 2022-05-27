//
//  LoginViewModel.swift
//  VPN
//
//  Created by Sergey on 19.05.2022.
//

import SwiftUI
import Firebase
import LocalAuthentication

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    
  
    //MARK: faceID properties
    @AppStorage("use_face_id") var useFaceID = false
    @AppStorage("use_face_email") var faceIDEmail = ""
    @AppStorage("use_face_password") var FaceIDPassword = ""
    
    //Log status
    @AppStorage("log_status") var logStatus = false
    
    //MARK: Error
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    //MARK: Firebase Login
    
    func loginUser(useFaceID: Bool, email: String = "", password: String = "") async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        DispatchQueue.main.async {
            if useFaceID && self.faceIDEmail == "" {
                
                self.useFaceID = useFaceID
                self.faceIDEmail = self.email
                self.FaceIDPassword = self.password
            }
            self.logStatus = true
        }
    }
    
        //MARK: FaceID Usage
    
    func getBiometricStatus() -> Bool {
        
        let bioScanner = LAContext()
        
        return bioScanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
        //MARK: FaceID login
    
    func authentificateUser() async throws {
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To login into app")
        
        if status {
            try await loginUser(useFaceID: useFaceID, email: self.faceIDEmail, password: self.FaceIDPassword)
        }
    }
}

