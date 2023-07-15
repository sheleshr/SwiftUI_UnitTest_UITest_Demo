//
//  LoginViewModel.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import Foundation

enum LoginStatus:Error, Equatable{
    case undefined
    case validationFailed
    case badUrl
    case denied(message:String)
    case authenticated
    
    static func ==(lhs: LoginStatus, rhs: LoginStatus) -> Bool{
        return (lhs.localizedDescription == rhs.localizedDescription)
    }
}

class LoginViewModel:ObservableObject{
    
    @Published var user = User(un: "", pass: "")
    @Published var loginStatus:LoginStatus = .undefined
    private var networkManager:NetworkManager
    
    init(networkmanager:NetworkManager) {
        self.networkManager = networkmanager
    }
    init(networkmanager:NetworkManager, user:User)
    {
        self.networkManager = networkmanager
        self.user = user
    }
    
    var errorMessage:String{
        switch self.loginStatus {
        case .authenticated:
            return ""
        case .validationFailed:
            return  "Invalid credentials"
        case .badUrl:
            return "Bad URL"
        case .denied(let reason):
            return  "Unknown user or " + reason
        default:
           return ""
        }
    }
    
    func login(){
        if user.validateUserInput() {
            guard let url = URL(string: APPURL.loginUrl) else{
                loginStatus = .badUrl
                return
            }
            var urlReq = URLRequest(url: url)
            urlReq.httpMethod = "POST"
            if let jsonData = try? JSONEncoder().encode(["username":user.username, "password":user.password]) {
                urlReq.httpBody = jsonData
            }
            
            
            networkManager.fetchRequest(urlReq: urlReq, modelType: LoginResponse.self) { result in
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.loginStatus = .denied(message: error.description)
                    }
                case .success(let model):
                    print("RESPONSE MODEL: \(model)")
                    DispatchQueue.main.async {
                    self.loginStatus = .authenticated
                        
                    }
                }
            }
        }else{
            loginStatus = .validationFailed
        }
    }
    
    func reset(){
        user = User(un: "", pass: "")
        loginStatus = .undefined
    }
    
}
