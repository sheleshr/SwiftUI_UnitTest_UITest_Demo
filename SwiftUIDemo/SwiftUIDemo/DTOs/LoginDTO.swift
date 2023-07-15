//
//  LoginDTO.swift
//  SwiftUIDemo
//
//  Created by Administrator on 05/07/22.
//

import Foundation


// MARK: - LoginResponse
struct LoginResponse: Codable {
    let responseStatus: ResponseStatus
    let contents: Contents
}

// MARK: - Contents
struct Contents: Codable {
    let name, email, phone: String
    let address: Address
}

// MARK: - Address
struct Address: Codable {
    let line1, line2, zipCode, city: String
    let state: String
}

// MARK: - Result
struct ResponseStatus: Codable {
    let statusCode: Int
    let desc: String

}
