//
//  NetworkManagerFactory.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import Foundation

class NetworkManagerFactory{
    
    static func create()-> NetworkManager{
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
                return NetworkManager(apiH: MockAPIHandlerDelegate())
            }else{
                return NetworkManager()
            }
        }else{
            return NetworkManager()
        }
        
    }
    
}
