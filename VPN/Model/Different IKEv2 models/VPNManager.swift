//
//  VPNManager.swift
//  VPN
//
//  Created by Sergey on 21.04.2022.
//

import SwiftUI
import Foundation
import NetworkExtension

protocol VpnDelegate: AnyObject {
    
//    func setStatus(status: Status)
    func checkNES(status: NEVPNStatus)
}
class VPNManager {
    
    let vpnManager = NEVPNManager.shared();
    var server_address : String
    var server_password: String
    var server_remoteIdentifier: String
    var server_LocalIdentifier: String
    var server_ServerCertificateIssuerCommonName: String
    weak var vpnDelegate: VpnDelegate?
    
    
    /// The static field that controls the access to the singleton instance.
    ///
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    
    static var shared: VPNManager = {
        let instance = VPNManager(serverAddress: "vpnde04.fornex.org", serverPassword: "wxPmDHyFclIhyM1Z", remoteIdentifier: "vpnde04.fornex.org", vpnLocalIdentifier: "dmitriy@fo_20475", vpnServerCertificateIssuerCommonName: "vpnde04.fornex.org")
        
        return instance
    }()
    
    private init(serverAddress address: String, serverPassword password: String, remoteIdentifier identifier: String, vpnLocalIdentifier localidentifier: String, vpnServerCertificateIssuerCommonName certificate: String) {
        self.server_address = address
        self.server_password = password
        self.server_remoteIdentifier = identifier
        self.server_LocalIdentifier = localidentifier
        self.server_ServerCertificateIssuerCommonName = certificate
    }
    
    private var vpnLoadHandler: (Error?) -> Void { return
        { (error:Error?) in
            if ((error) != nil) {
//                self.vpnDelegate?.setStatus(status: Status.errorConnecting)
                print("vpnLoadHandler Could not load VPN Configurations : \(String(describing: error))")
                return;
            }
            
            let p = NEVPNProtocolIKEv2()
            p.authenticationMethod = NEVPNIKEAuthenticationMethod.none
            p.username = "dmitriy@fo_20475"
            p.serverAddress = "vpnde04.fornex.org"
            p.authenticationMethod = .none
//            p.username = self.server_LocalIdentifier
//            p.serverAddress = self.server_address
//            p.remoteIdentifier = self.server_remoteIdentifier
//            p.serverCertificateCommonName = self.server_ServerCertificateIssuerCommonName
//            p.localIdentifier = self.server_LocalIdentifier
            
            /// Required
            
            
            
            
            
            let kcs = KeychainService()
            
            kcs.save(key: "VPN_PASSWORD", value: "wxPmDHyFclIhyM1Z")
//            kcs.save(key: "SHARED", value: "86f7be40d8de4b45b6139cd0b233275f")// Enter your password
//            p.sharedSecretReference = kcs.load(key: "SHARED")
            p.passwordReference = kcs.load(key: "VPN_PASSWORD")// Required type is Data
            p.useExtendedAuthentication = false
            p.disconnectOnSleep = false
            p.remoteIdentifier = self.server_address /// Required
            
            p.ikeSecurityAssociationParameters.diffieHellmanGroup = NEVPNIKEv2DiffieHellmanGroup.group2
            p.ikeSecurityAssociationParameters.encryptionAlgorithm = NEVPNIKEv2EncryptionAlgorithm.algorithmAES128
            p.ikeSecurityAssociationParameters.integrityAlgorithm = NEVPNIKEv2IntegrityAlgorithm.SHA96
            p.ikeSecurityAssociationParameters.lifetimeMinutes = 1140
            
            p.childSecurityAssociationParameters.diffieHellmanGroup = NEVPNIKEv2DiffieHellmanGroup.group2
            p.childSecurityAssociationParameters.encryptionAlgorithm = NEVPNIKEv2EncryptionAlgorithm.algorithmAES128
            p.childSecurityAssociationParameters.integrityAlgorithm = NEVPNIKEv2IntegrityAlgorithm.SHA96
            p.childSecurityAssociationParameters.lifetimeMinutes = 1140
            
            
            self.vpnManager.protocolConfiguration = p
            self.vpnManager.localizedDescription = "DE2" // The VPN Name saved in your setting
            self.vpnManager.isOnDemandEnabled = false
            
            /// You can set rules for On Demand Connection
            let rule1 : NEOnDemandRule = NEOnDemandRule()
            rule1.setValuesForKeys(["Action" : NEOnDemandRuleAction.connect, "InterfaceTypeMatch" : NEOnDemandRuleInterfaceType.wiFi])
            
            let rule2 : NEOnDemandRule = NEOnDemandRule()
            rule2.setValuesForKeys(["Action" : NEOnDemandRuleAction.connect, "InterfaceTypeMatch" : NEOnDemandRuleInterfaceType.cellular])
            
            let connectRule = NEOnDemandRuleConnect()
            connectRule.interfaceTypeMatch = .any
            self.vpnManager.onDemandRules = [connectRule]
            
            
            
            //        do {
            //
            //
            //        let rule1 : NEOnDemandRuleConnect = NEOnDemandRuleConnect()
            //
            //        rule1.setValue(NEOnDemandRuleAction.connect, forKeyPath: "Action")
            //        //rule1.setValue(NEOnDemandRuleAction.connect, forKey: "Action")
            //        //rule1.setValue(NEOnDemandRuleAction.connect, forKeyPath:)
            //        //rule1.setValue(NEOnDemandRuleAction.connect, forUndefinedKey: "Action")
            //
            //        //rule1.setValuesForKeys(["Action" : NEOnDemandRuleAction.connect, "InterfaceTypeMatch" : NEOnDemandRuleInterfaceType.wiFi])
            //        rule1.setValue(NEOnDemandRuleInterfaceType.wiFi, forKeyPath: "InterfaceTypeMatch")
            //
            //
            //        let rule2 : NEOnDemandRule = NEOnDemandRule()
            //        rule2.setValue(NEOnDemandRuleAction.connect, forKeyPath: "action")
            //        rule2.setValue(NEOnDemandRuleInterfaceType.cellular, forKeyPath: "InterfaceTypeMatch")
            //
            //        self.vpnManager.protocolConfiguration = p
            //        self.vpnManager.onDemandRules = [rule2, rule1]
            //
            //        } catch {
            //            Log.d(message:  "Error info: \(error)")
            //        }
            //
            self.vpnManager.isEnabled = true
            self.vpnManager.saveToPreferences(completionHandler: self.vpnSaveHandler)
        }
        
    }
    
    private var vpnSaveHandler: (Error?) -> Void { return
        { (error:Error?) in
            if (error != nil) {
                print("vpnSaveHandler Could not save VPN Configurations \(String(describing: error?.localizedDescription))")
                return
            } else {
                do {
                    print("vpnSaveHandler do")
                    try self.vpnManager.connection.startVPNTunnel()
                    
                } catch let error {
                    
                    print("Error starting VPN Connection \(error.localizedDescription)");
                }
            }
        }
        //self.vpnlock = false
    }
    
    public func connectVPN() {
        //For no known reason the process of saving/loading the VPN configurations fails.On the 2nd time it works
        print("connectVPN")
        self.vpnManager.loadFromPreferences(completionHandler: self.vpnLoadHandler)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NEVPNStatusDidChange, object: nil , queue: nil) {
            notification in
            let nevpnconn = notification.object as! NEVPNConnection
            let status = nevpnconn.status
            self.vpnDelegate?.checkNES(status: status)
        }
    }
    
    public func disconnectVPN() ->Void {
        self.vpnManager.loadFromPreferences { error in
            assert(error == nil, "Failed to load preferences: \(error!.localizedDescription)")
            self.vpnManager.connection.stopVPNTunnel()
            NotificationCenter.default.addObserver(forName: NSNotification.Name.NEVPNStatusDidChange, object: nil , queue: nil) {
                notification in
                let nevpnconn = notification.object as! NEVPNConnection
                let status = nevpnconn.status
                self.vpnDelegate?.checkNES(status: status)
            }
        }
    }
}
