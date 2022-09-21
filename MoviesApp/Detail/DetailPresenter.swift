//
//
// DetailPresenter.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation
import UIKit

protocol DetailProtocol : AnyObject {
    
    
    func hideLoader()
    func showLoader()
    func showError(_ message: String)
    func setDataMovie()
    
}

protocol DetailPresenterProtocol {
    var movie: Movie? { get set }
    var listMovieSave: [Int] { get set }
    
    func getMovieById(_ id: Int)
    
    func saveMovie()
    func getFavorite() -> Bool
    func removeFavorite()
}

class DetailPresenter: DetailPresenterProtocol {
    var movie: Movie?
    var listMovieSave: [Int] = []
    
    private weak var delegate: DetailProtocol?
    let localManager = LocalManager(modelName: Constants.DataBaseName)
    
    init(delegate: DetailProtocol) {
        self.delegate = delegate
        
        self.getListMovieSave()
    }
    
    private func getListMovieSave() {
        listMovieSave = localManager.getListIDMovie()
        
    }
    
    func getMovieById(_ id: Int) {
        self.delegate?.showLoader()
        
        APIClient().dataRequest(with: .movie, body: nil, getParams: id.description, objectType: Movie.self) { response in
            self.delegate?.hideLoader()
            switch response {
            case .success(let val) :
                
                self.movie = val
                
                DispatchQueue.main.async {
                    self.delegate?.setDataMovie()
                }
                
            case .failure(let error) :
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    func saveMovie() {
        guard let movie = movie else {
            debugPrint("Not save movie")
            return
        }
        localManager.saveMovie(movie)
        self.getListMovieSave()
    }
    
    func getFavorite() -> Bool {
        if let id = movie?.id {
            return listMovieSave.contains(id)
        }
        return false
    }
    
    func removeFavorite() {
        if let id = movie?.id {
            localManager.removeMovie(idMovie: id)
            self.getListMovieSave()
        }
    }
}

