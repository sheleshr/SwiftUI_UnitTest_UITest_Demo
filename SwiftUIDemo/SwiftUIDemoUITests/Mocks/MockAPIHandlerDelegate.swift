//
//  MockAPIHandlerDelegate.swift
//  SwiftUIDemoUITests
//
//  Created by Administrator on 05/07/22.
//

import Foundation



class MockAPIHandlerDelegate:APIHandlerDelegate{
    func fetchData(urlReq: URLRequest, completion: @escaping (Result<Data, MyError>) -> Void) {
       
        
        if urlReq.url?.absoluteString == APPURL.loginUrl{
            if let path = Bundle.main.path(forResource: "LoginJSON", ofType: "txt"),
                let data = FileManager.default.contents(atPath: path){
                completion(.success(data))
            }else{
                completion(.failure(.NoData(message: "or bad url")))
            }
        }
    }
    
    
}
