//
//
// CategoryCell.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewForm.layer.borderWidth = 1
        viewForm.layer.borderColor = UIColor(named: Constants.Colors.primary)?.cgColor
        viewForm.layer.cornerRadius = 4
        // Initialization code
    }
    
    func loadCell(name: String) {
        lblCategory.text = name
    }

}
