//
//
// Localize.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

/**
 Contiene todos los accesos a cada una de las descripciones de texto, para mostrar alertas, títulos de menú, etiquetas etc.
 */
func localizedString(forKey key: String) -> String {
   
    var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)

    if result == key {
        result = Bundle.main.localizedString(forKey: key, value: nil, table: "Localize")
    }

    return result
}

extension String {
    static let msgErrorUserLogin = localizedString(forKey: "msgErrorUserLogin")
    static let Continue = localizedString(forKey: "Continue")
    static let Verify = localizedString(forKey: "Verify")
    static let msgWhatDoYouWantToDo = localizedString(forKey: "msgWhatDoYouWantToDo")
    static let lblViewProfile = localizedString(forKey: "lblViewProfile")
    static let lblLogOut = localizedString(forKey: "lblLogOut")
    static let Cancel = localizedString(forKey: "Cancel")    
}
