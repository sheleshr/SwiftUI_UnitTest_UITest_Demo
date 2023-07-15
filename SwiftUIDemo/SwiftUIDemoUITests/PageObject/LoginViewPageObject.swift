//
//  LoginViewPageObject.swift
//  SwiftUIDemoUITests
//
//  Created by Administrator on 05/07/22.
//

import XCTest

class LoginViewPageObject{
    private var app:XCUIApplication!
    init(app:XCUIApplication)
    {
        self.app = app
    }
    var usernameField:XCUIElement {
        return app.textFields["usernameTxtFd"]
    }
    var passwordField:XCUIElement {
        return app.textFields["passwordTxtFd"]
    }
    var loginButton:XCUIElement{
        return app.buttons["loginBtn"]
    }
    var messageText:XCUIElement{
        return app.staticTexts["messageTxt"]
    }
    var navigationBar:XCUIElement{
        //return app.navigationBars["Home"]
        return app.staticTexts["Home"]
    }
}
