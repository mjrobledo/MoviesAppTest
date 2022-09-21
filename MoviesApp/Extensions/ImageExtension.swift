//
//
// ImageExtension.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

extension UIImageView {
    
    func imageFromServerUrl(urlString: String, placeholder: UIImage) {
        
        if self.image == nil {
            self.image = placeholder
        }
        
        if urlString.isEmpty {
            return
        }
            
        URLSession.shared.dataTask(with: URL(string:urlString)!) { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}
