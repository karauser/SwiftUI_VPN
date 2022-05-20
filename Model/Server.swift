//
//  Server.swift
//  VPN
//
//  Created by Sergey on 17.04.2022.
//

import Foundation

//hardcode server
    struct HardcodeServer: Identifiable {
        
        var id = UUID().uuidString
        var name: String
        var flag: String
        var ping: String
    }
    

    var servers = [
        
        HardcodeServer(name: "Amsterdam", flag: "am", ping: "31"),
        HardcodeServer(name: "Belarus", flag: "by", ping: "375"),
        HardcodeServer(name: "UK", flag: "uk", ping: "44"),
        HardcodeServer(name: "Belgium", flag: "bg", ping: "56"),
        HardcodeServer(name: "Indonesia", flag: "in", ping: "62"),
    ]


