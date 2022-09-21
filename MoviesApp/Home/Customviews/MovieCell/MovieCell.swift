//
//
// MovieCell.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var favorite = { (movieID: Int) in }
    private var idMovie: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadCellWithMovie(_ movie: Movie) {
        self.idMovie = movie.id
        
        lblName.text = movie.title
        lblDate.text = movie.release_date
        lblRating.text = movie.vote_average?.description
        lblDescription.text = movie.overview
        
        imgMovie.imageFromServerUrl(urlString: movie.urlImage, placeholder: UIImage())
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        favorite(self.idMovie!)
    }
}
