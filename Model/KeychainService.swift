//
//  KeychainService.swift
//  VPN
//
//  Created by Sergey on 21.04.2022.
//


import Foundation
import UIKit
import Security
// Identifiers
let serviceIdentifier = "MySeriviceVPNTestApp"
let userAccount = "authenticatedUserVPNTestApp"
let accessGroup = "MySeriviceVPNTestApp"
// Arguments for the keychain queries
var kSecAttrAccessGroupSwift = NSString(format: kSecClass)
let kSecClassValue = kSecClass as CFString
let kSecAttrAccountValue = kSecAttrAccount as CFString
let kSecValueDataValue = kSecValueData as CFString
let kSecClassGenericPasswordValue = kSecClassGenericPassword as CFString
let kSecAttrServiceValue = kSecAttrService as CFString
let kSecMatchLimitValue = kSecMatchLimit as CFString
let kSecReturnDataValue = kSecReturnData as CFString
let kSecMatchLimitOneValue = kSecMatchLimitOne as CFString
let kSecAttrGenericValue = kSecAttrGeneric as CFString
let kSecAttrAccessibleValue = kSecAttrAccessible as CFString

class KeychainService: NSObject {
    func save(key:String, value:String) {
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let valueData: Data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        
        let keychainQuery = NSMutableDictionary();
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        keychainQuery[kSecValueData as! NSCopying] = valueData;
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    func load(key: String)->Data {
        
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let keychainQuery = NSMutableDictionary();
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        keychainQuery[kSecMatchLimit] = kSecMatchLimitOne
        keychainQuery[kSecReturnPersistentRef] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0)) }
        
        if status == errSecSuccess {
            if let data = result as! NSData? {
                if NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) != nil {
                }
                return data as Data;
            }
        }
        return "".data(using: .utf8)!;
    }
}
