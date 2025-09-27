//
//  NetWorkHelper.swift
//  MagdyTask
//
//  Created by AMNY on 21/08/2025.
//


import UIKit
import Network
import SwiftKeychainWrapper
class NetWorkHelper{
    static var shared = NetWorkHelper()
    func Headers () -> [String:String] {
        let toLanguage = "en"
        let token = KeychainWrapper.standard.string(forKey: "authToken") ?? ""
        print("token is \(String(describing: token))")
        return [
          "token": token,
          "Authorization": "Bearer \(token)",
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-Language":"\(toLanguage)",
          "Connection": "keep-alive",
          "X-device": "ios"
        ]
    }
    
    
}
