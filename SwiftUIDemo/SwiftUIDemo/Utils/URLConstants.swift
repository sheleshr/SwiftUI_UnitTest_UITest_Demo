//
//  Constants.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import Foundation

struct APPURL {

    private struct Domains {
        static let Dev = "http://test-dev.xxxxx.net"
        static let UAT = "http://test-UAT.xxxxx.com"
        static let Local = "192.145.1.1"
        static let QA = "http://test-QA.xxxxx.com"
    }

    private  struct Routes {
        static let api = "/api/mobile"
    }

    private  static let domain = Domains.Dev
    private  static let route = Routes.api
    private  static let baseURL = domain + route

    
}
extension APPURL {
    static var loginUrl: String {
        return baseURL  + "/login"
    }
}
