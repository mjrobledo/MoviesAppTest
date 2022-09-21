//
//
// CollMovieManager.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation
import UIKit

class CollMovieManager : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var data: [Movie] = []
    var index: Int?
    
    var selectedIndex = { (idMovie: Int, name: String)  in }
     
    
    func setData(data: [Movie]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.loadCellWithMovie(data[indexPath.row])
        
        cell.btnFavorite.setImage(UIImage(systemName: Constants.Images.favorite), for: .normal)
        
        if Singleton.instance.favoriteList.contains(data[indexPath.row].id!) {
            cell.btnFavorite.setImage(UIImage(systemName: Constants.Images.favoriteFill), for: .normal)
        }
        
        cell.favorite = { idMovie in
             
            if Singleton.instance.favoriteList.contains(idMovie) {
                LocalManager(modelName: Constants.DataBaseName).removeMovie(idMovie: idMovie)
            } else {
                LocalManager(modelName: Constants.DataBaseName).saveMovie(self.data[indexPath.row])
            }
            collectionView.reloadItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex(data[indexPath.row].id!, data[indexPath.row].title ?? "")
    }
    
}

extension CollMovieManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        
        return CGSize(width: width, height: 240)
    }
}
