//
//  SwiftUIDemoUITests.swift
//  SwiftUIDemoUITests
//
//  Created by Administrator on 05/07/22.
//

import XCTest
@testable import SwiftUIDemo

class when_application_launch_with_default_UI: XCTestCase {
    var loginViewPageObject:LoginViewPageObject!

    override func setUp() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV":"TEST"]
        app.launch()
        loginViewPageObject = LoginViewPageObject(app: app)
    }
    func test_loginview_should_be_empty(){
        XCTAssertEqual(loginViewPageObject.usernameField.label, "")
        XCTAssertEqual(loginViewPageObject.passwordField.label, "")
        XCTAssertEqual(loginViewPageObject.loginButton.label, "Login")
        XCTAssertEqual(loginViewPageObject.messageText.label, "")
    }
    
}

class when_user_click_on_login_button:XCTestCase{
    var loginViewPageObject:LoginViewPageObject!

    override func setUp() {
        let app = XCUIApplication()
        //print("###########")
        //print(app.debugDescription)
        continueAfterFailure = false
        app.launchEnvironment = ["ENV":"TEST"]
        app.launch()
        loginViewPageObject = LoginViewPageObject(app: app)
    }
    func test_should_display_error_message_if_fields_are_empty(){
        loginViewPageObject.usernameField.tap()
        loginViewPageObject.usernameField.typeText("")
        loginViewPageObject.passwordField.tap()
        loginViewPageObject.passwordField.typeText("")
        loginViewPageObject.loginButton.tap()
        
        XCTAssertEqual(loginViewPageObject.messageText.label, "Invalid credentials")
    }
    
    func test_when_user_input_valid_credential(){
        loginViewPageObject.usernameField.tap()
        loginViewPageObject.usernameField.typeText("uswrA123")
        loginViewPageObject.passwordField.tap()
        loginViewPageObject.passwordField.typeText("131@#@#sd")
        loginViewPageObject.loginButton.tap()
        
        XCTAssertTrue(loginViewPageObject.navigationBar.waitForExistence(timeout: 0.5))
    }
 
    
}
