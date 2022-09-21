//
//
// SessionModel.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

struct SessionResponse : Codable {
    let success : Bool?
    var expiresAt : String?
    let requestToken : String?
    let statusCode: Int?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        expiresAt = try values.decodeIfPresent(String.self, forKey: .expiresAt)
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMessage = try values.decodeIfPresent(String.self, forKey: .statusMessage)
    }
}


struct LoginRequets : Codable {
    
    let username : String?
    let password : String?
    let requestToken : String?

    enum CodingKeys: String, CodingKey {

        case username = "username"
        case password = "password"
        case requestToken = "request_token"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        requestToken = try values.decodeIfPresent(String.self, forKey: .requestToken)
        
    }

    init(username : String, password : String, requestToken : String?) {
        self.username = username
        self.password = password
        self.requestToken = requestToken
    }
}
