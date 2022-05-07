//
//  VPNManagerBeta.swift
//  VPN
//
//  Created by Sergey on 22.04.2022.
//

//import Foundation
//import NetworkExtension
//
//class VPN {
//
//let vpnManager = NEVPNManager.shared()
//
//private var vpnLoadHandler: (Error?) -> Void { return
//        { (error:Error?) in
//            if ((error) != nil) {
//                print("Could not load VPN Configurations")
//                return
//            }
//            let p = NEVPNProtocolIPSec()
//            p.username = "dmitriy@fo_20475"
//            p.serverAddress = "vpnde04.fornex.org"
//            p.authenticationMethod = NEVPNIKEAuthenticationMethod.none
//
//            let kcs = KeychainService()
//            kcs.save(key: "SHARED", value: "86f7be40d8de4b45b6139cd0b233275f")
//            kcs.save(key: "VPN_PASSWORD", value: "wxPmDHyFclIhyM1Z")
//            p.sharedSecretReference = kcs.load(key: "SHARED")
//            p.passwordReference = kcs.load(key: "VPN_PASSWORD")
//            p.useExtendedAuthentication = true
//            p.disconnectOnSleep = false
//            self.vpnManager.protocolConfiguration = p
//            self.vpnManager.localizedDescription = "Contensi"
//            self.vpnManager.isEnabled = true
//            self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
//    } }
//
//private var vpnSaveHandler: (Error?) -> Void { return
//    { (error:Error?) in
//        if (error != nil) {
//            print("Could not save VPN Configurations")
//            return
//        } else {
//            do {
//                try self.vpnManager.connection.startVPNTunnel()
//            } catch let error {
//                print("Error starting VPN Connection \(error.localizedDescription)")
//                }
//            }
//        }
////        self.vpnlock = false
//    }
//
//public func connectVPN() {
//        //For no known reason the process of saving/loading the VPN configurations fails.On the 2nd time it works
//        do {
//            try self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
//        } catch let error {
//            print("Could not start VPN Connection: \(error.localizedDescription)" )
//        }
//    }
//
//public func disconnectVPN() ->Void {
//        vpnManager.connection.stopVPNTunnel()
//}
//
//}
