//
//
// Singleton.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

open class Singleton: NSObject {
    static let instance: Singleton = {
        let instance = Singleton()
        return instance
    }()
 
    
    var session: SessionResponse?

    var favoriteList : [Int] {
      return LocalManager(modelName: Constants.DataBaseName).getListIDMovie()
    }
}
