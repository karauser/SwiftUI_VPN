////
////  VPNIKEv2Gamma.swift
////  VPN
////
////  Created by Sergey on 16.05.2022.
////
//
//import Foundation
//import NetworkExtension
//
//  // MARK: - NEVPNManager
//    // MARK: -
//
//
//    private var vpnLoadHandler: (Error?) -> Void { return
//    { (error:Error?) in
//        if ((error) != nil) {
//            print("Could not load VPN Configurations")
//            self.removeToast()
//            return;
//        }
//
//        self.showToast(msg: STRINGVALUES.kCreatingConnection)
//
//
//        //VPN connection via Username password
//        let p = NEVPNProtocolIPSec()
//        let kcs = KeychainService()
//        p.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
//
//        //For the security purpose added word xyz in password .so it should be remove while connecting
//
//
//        if self.selectedSever != nil{
//            self.selectedSever?.password = (self.selectedSever?.password.replacingOccurrences(of: "xyz", with: ""))!
//            p.username = self.selectedSever?.userName
//            p.serverAddress = self.selectedSever?.serverAddress
//            kcs.save(key: "SHARED", value: (self.selectedSever?.password)!)
//
//            kcs.save(key: "VPN_PASSWORD", value: (self.selectedSever?.password)!)
//            p.sharedSecretReference = kcs.load(key: STRINGVALUES.kShared)
//            p.passwordReference = kcs.load(key: STRINGVALUES.kVPN_Pswd)
//            p.useExtendedAuthentication = true
//            p.disconnectOnSleep = false
//
//            // Check for free subscriber
//            if self.selectedSever?.serverType == STRINGVALUES.VIP.lowercased() && !Singleton.checkForPaidReciept(){
//
//                self.disconnectVPN()
//                Helper.showAlert(sender: self, title: STRINGVALUES.AppName, message: AlertMessage.kValidateSubscription)
//                return
//
//            }
//
//
//            self.vpnManager.protocolConfiguration = p
//            self.vpnManager.localizedDescription = STRINGVALUES.AppName
//            self.vpnManager.isEnabled = true
//
//            self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
//        }else{
//
//        }
//
//
//        }
//
//    }
//
//
//    private var vpnSaveHandler: (Error?) -> Void { return
//    { (error:Error?) in
//        if (error != nil) {
//            print("Could not save VPN Configurations")
//            self.removeToast()
//            return
//        } else {
//            do {
//                try self.vpnManager.connection.startVPNTunnel()
//            } catch let error {
//                print("Error starting VPN Connection \(error.localizedDescription)");
//                self.removeToast()
//            }
//        }
//        }
//        //self.vpnlock = false
//    }
//
//
//
//    public func connectVPN() {
//        //For no known reason the process of saving/loading the VPN configurations fails.On the 2nd time it works
//        do {
//            try self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
//
//        } catch let error {
//            print("Could not start VPN Connection: \(error.localizedDescription)" )
//            self.removeToast()
//        }
//    }
//
//    public func disconnectVPN() ->Void {
//        vpnManager.connection.stopVPNTunnel()
//
//
//    }
//
//    func vpnConnectionStatusChanged(){
//
//       let status = self.vpnManager.connection.status
//        print("VPN connection status = \(status)")
//
//        switch status {
//        case NEVPNStatus.connected:
//
//            showToast(msg: STRINGVALUES.kConnected)
//
//
//
//
//        case NEVPNStatus.invalid, NEVPNStatus.disconnected :
//
//            showToast(msg: STRINGVALUES.kDisconnected)
//
//
//        case NEVPNStatus.connecting , NEVPNStatus.reasserting:
//
//            showToast(msg: STRINGVALUES.kConnecting)
//
//
//        case NEVPNStatus.disconnecting:
//            showToast(msg: STRINGVALUES.kDisconnecting)
//
//        default:
//            print("Unknown VPN connection status")
//        }
//
//    }
