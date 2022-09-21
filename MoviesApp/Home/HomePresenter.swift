//
//
// HomePresenter.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

protocol HomeProtocol : AnyObject {
    func hideLoader()
    func showError(_ message: String)
     
    func reloadGenres()
    func setTitle(name: String)
    func reloadMovies(movies: [Movie])
    func reloadCollectionMovies()
    
}

protocol HomePresenterProtocol {
    var genres: [GenresModel] { get set}
    
    func getGenres()
    func getGenreByIndex( _ index: Int)
    func loadFirstGenre()
    func favoriteAction(movieID: Int)
}


class HomePresenter: HomePresenterProtocol {
     
    
    var genres = [GenresModel]()
    let localManager = LocalManager(modelName: Constants.DataBaseName)
    
    private weak var delegate: HomeProtocol?
    private var genreSelected = -1
    
    init(delegate: HomeProtocol) {
        self.delegate = delegate
         
    }
    
    func getGenres() {        
        APIClient().dataRequest(with: .genre, body: nil, objectType: GenresResponse.self) { response in
            switch response {
            case .success(let val) :
                
                self.genres = val.genres ?? []
                self.delegate?.reloadGenres()
                
                if self.genreSelected == -1 {
                    self.getGenreByIndex(0)
                }
                
            case .failure(let error) :
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    func getGenreByIndex( _ index: Int) {
        if self.genres.isEmpty {
            return
        }
        
        guard let id = self.genres[index].id else {
            return
        }
        
        genreSelected = id
        delegate?.setTitle(name: genres[index].name ?? "")
        getListMovies(idGenre: genreSelected)
    }
    
    func loadFirstGenre() {
        if let genre = genres.first {
            getListMovies(idGenre: genre.id!)
        }
    }
    
    private func getListMovies(idGenre: Int) {
        APIClient().dataRequest(with: .movies, body: nil, getParams: idGenre.description, objectType: MovieResponse.self) { response in
            switch response {
            case .success(let val) :
                
                self.delegate?.reloadMovies(movies: val.results ?? [])
            case .failure(let error) :
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    func favoriteAction(movieID: Int) {
        if Singleton.instance.favoriteList.contains(movieID) {
            localManager.removeMovie(idMovie: movieID)
            self.delegate?.reloadCollectionMovies()
        } else {
            getMovieService(movieID: movieID)
        }
    }
    
    private func getMovieService(movieID: Int) {
        
        APIClient().dataRequest(with: .movie, body: nil, getParams: movieID.description, objectType: Movie.self) { response in
            self.delegate?.hideLoader()
            switch response {
            case .success(let val) :
                
                self.localManager.saveMovie(val)
                self.delegate?.reloadCollectionMovies()
            
            case .failure(let error) :
                self.delegate?.showError(error.localizedDescription)
            }
        }
        
    }
}
