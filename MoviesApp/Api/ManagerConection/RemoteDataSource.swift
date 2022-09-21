//
//
// Manager.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

protocol ManagerLoginProtocol {
    
}

final class APIClient {
    //APPError enum which shows all possible errors
    enum APPError: Error {
        case networkError(Error)
        case dataNotFound
        case jsonParsingError(Error)
        case invalidStatusCode(Int)
    }
    
    //Result enum to show success or failure
    enum ApiResult<T> {
        case success(T)
        case failure(APPError)
    }
    
    //dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with api: Api, body: Data? = nil, getParams: String? = "", objectType: T.Type,  completion: @escaping (ApiResult<T>) -> Void) {
        
        var url = api.apiURL()
        
        if getParams != nil {
            url = api.apiURL(data: getParams)
        }
        
        let dataURL = URL(string: url)!
        
        let sessionConfiguration = URLSessionConfiguration.default
        
        if let token = Singleton.instance.session?.requestToken {
            sessionConfiguration.httpAdditionalHeaders = [
                "Authorization": "Bearer \(token)"
            ]
        }
        
         
        var request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        if let token = Singleton.instance.session?.requestToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authentication")
        }
        
        request.httpMethod = api.method.rawValue
        
        if body != nil {
            request.httpBody = body
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
         
        let session = URLSession(configuration: sessionConfiguration)
        
        
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)                
            }
            
            guard error == nil else {
                completion(ApiResult.failure(APPError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(ApiResult.failure(APPError.dataNotFound))
                return
            }
            
            do {
                //create decodable object from data
               // debugPrint(String(data: data, encoding: .utf8) ?? "")
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(ApiResult.success(decodedObject))
            } catch let error {
                completion(ApiResult.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
    
     
}

