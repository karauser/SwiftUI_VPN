//
//  VPNManagerAlpha.swift
//  VPN
//
//  Created by Sergey on 22.04.2022.
//

import Foundation
import NetworkExtension

class VPN {

 let vpnManager = NEVPNManager.shared()

private var vpnLoadHandler: (Error?) -> Void { return
        { (error:Error?) in
            if ((error) != nil) {
                print("Could not load VPN Configurations")
                return
            }
            let p = NEVPNProtocolIKEv2()
            p.username = "dmitriy@fo_20475"
            p.serverAddress = "vpnde04.fornex.org"
            p.authenticationMethod = NEVPNIKEAuthenticationMethod.none

            let kcs = KeychainService()
           
            kcs.save(key: "VPNPASSWORD", value: "wxPmDHyFclIhyM1Z")
           
            p.passwordReference = kcs.load(key: "VPNPASSWORD")
            p.useExtendedAuthentication = true
            p.disconnectOnSleep = false
            self.vpnManager.protocolConfiguration = p
            self.vpnManager.localizedDescription = "Contensi2"
            self.vpnManager.isEnabled = true
            self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
    } }

private var vpnSaveHandler: (Error?) -> Void { return
    { (error:Error?) in
        if (error != nil) {
            print("Could not save VPN Configurations")
            return
        } else {
            do {
                try self.vpnManager.connection.startVPNTunnel()
            } catch let error {
                print("Error starting VPN Connection \(error.localizedDescription)")
                }
            }
        }
//        self.vpnlock = false
    }

public func connectVPN() {
        //For no known reason the process of saving/loading the VPN configurations fails.On the 2nd time it works
      
        self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
        }
    

public func disconnectVPN() ->Void {
        vpnManager.connection.stopVPNTunnel()
}

}
