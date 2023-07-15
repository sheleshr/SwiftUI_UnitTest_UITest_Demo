//
//  SwiftUIDemoUnitTests.swift
//  SwiftUIDemoUnitTests
//
//  Created by Administrator on 06/07/22.
//

import XCTest
//@testable import SwiftUIDemo
class user_validation: XCTestCase {

    func test_empty_username_and_password(){
        let usr = User(un: "", pass: "")
        
        XCTAssertFalse(usr.validateUserInput())        
    }
    func test_invalid_username_and_password(){
        let usr = User(un: "@#@#", pass: "1234")
        XCTAssertFalse(usr.isValidUsername())
        XCTAssertFalse(usr.isValidPassword())
    }
}

class when_click_on_login_button:XCTestCase{
    
    func test_should_set_error_when_username_and_password_are_blank(){
        let vm = LoginViewModel(networkmanager: NetworkManagerFactory.create())
        vm.login()
        XCTAssertEqual(vm.loginStatus, LoginStatus.validationFailed)
        XCTAssertEqual(vm.errorMessage, "Invalid credentials")
    }
    func test_should_set_error_when_username_or_password_are_invalid(){
        let nm = NetworkManagerFactory.create()
        let usr = User(un: "@##", pass: "123")
        let vm = LoginViewModel(networkmanager: nm, user: usr)
        vm.login()
        XCTAssertEqual(vm.loginStatus, LoginStatus.validationFailed)
        XCTAssertEqual(vm.errorMessage, "Invalid credentials")
    }
    func test_loginstatus_should_authenticated_when_username_or_password_are_valid(){
        let nm = NetworkManager(apiH: MockAPIHandlerDelegate())
        let usr = User(un: "3123ssweqw", pass: "123434s#!@#")
        let vm = LoginViewModel(networkmanager: nm, user: usr)
        vm.login()
        XCTAssertEqual(vm.loginStatus, LoginStatus.undefined)
        XCTAssertEqual(vm.errorMessage, "")
    }
}
class APIHandlerUnitTest:XCTestCase{
    func test_with_url_not_exist(){
        let apiHandler = APIHandler()
        let url = URL(string: APPURL.loginUrl)!
        let urlReq = URLRequest(url: url)
        let expectation = expectation(description: "loginWebServiceCall")
        var myresult:Result<Data, MyError>? = nil
        apiHandler.fetchData(urlReq: urlReq) { result in
            myresult = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        switch myresult{
        case .failure(let err):
            XCTAssertEqual(err.description, MyError.NoData(message: "A server with the specified hostname could not be found.").description)
        case .success(let data):
            XCTAssertNotNil(data)
        default:
            XCTAssertTrue(true)
        }
    }
}
