//
//
// CollCategoryManager.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation
import UIKit

class CollCategoryManager : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var data: [GenresModel] = []
    private var index: Int?
    
    var selectedIndex = { (index: Int) in }
    
    func setData(data: [GenresModel]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.loadCell(name: data[indexPath.row].name ?? "")
        
        cell.backgroundColor = .white
        if index == indexPath.row {
            cell.backgroundColor = UIColor(named: Constants.Colors.primary)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        selectedIndex(indexPath.row)
        collectionView.reloadData()
    }
    
}


extension CollCategoryManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 3) // 15 because of paddings
        
        return CGSize(width: width, height: 45)
    }
}
