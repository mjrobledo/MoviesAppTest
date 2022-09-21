//
//
// ProfilePresenter.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 21/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation


protocol ProfileProtocol : AnyObject {
    func hideLoader()
    func showLoader()
    func showError(_ message: String)
 
    func hideSectionFavorites()
    func reloadMovies(movies: [Movie])
}

protocol ProfilePresenterProtocol {
    func getMovieList()
}

class ProfilePresenter: ProfilePresenterProtocol {
    private weak var delegate: ProfileProtocol?
    
    let localManager = LocalManager(modelName: Constants.DataBaseName)
    
    init(delegate: ProfileProtocol) {
        self.delegate = delegate
    }
     
    func getMovieList() {
        let localMovies = localManager.getMovies()
        if localMovies.isEmpty {
            delegate?.hideSectionFavorites()
            return
        }
        
       let movies = localMovies.map { localMovie -> Movie in
           
           let movie = Movie(id: Int(localMovie.idMovie),
                              overview: localMovie.overview ?? "",
                              poster_path: localMovie.poster_path ?? "",
                              vote_average: localMovie.vote_average,
                              release_date: localMovie.release_date ?? "")
           return movie
        }
        
        self.delegate?.reloadMovies(movies: movies)
    }
}
