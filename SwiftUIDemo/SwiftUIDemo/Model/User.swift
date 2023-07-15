//
//  User.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import Foundation

class User{
    var username = ""
    var password = ""
    init(un:String, pass:String) {
        self.username = un
        self.password = pass
    }
    func isValidUsername()-> Bool{
        return username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && username != ""
    }
    func isValidPassword()->Bool{
        return (!password.isEmpty && password.count>=8)
    }
    func validateUserInput()-> Bool {
        if isValidUsername() && isValidPassword() {
            return true
        }
        return false
    }
}
