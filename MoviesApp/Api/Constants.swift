//
//
// Constants.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

struct Constants {
    
    struct Url {
        static let apiURL = "https://api.themoviedb.org/"
        static let apiImage = "https://image.tmdb.org/t/p/w200/"
    }
    
    struct ApiKeys {
        static let theMovieKey = "c01f1df2fb4c5a34dd0129988509521e"
    }
    
    static let DataBaseName = "DataBase"
    
    struct Images {
        static let menu = "filemenu.and.cursorarrow"
        static let favorite = "bookmark"
        static let favoriteFill = "bookmark.fill"
    }
    
    struct Colors {
        static let primary = "PrimaryColor"
    }
}

// MARK: - Llamadas a servicios

enum Api: String {
    
    case requestToken = "3/authentication/token/new?api_key="
    case login = "3/authentication/token/validate_with_login?api_key="
    case genre = "3/genre/movie/list?api_key=%@&language=en-US"
    case movies = "3/discover/movie?api_key=%@&with_genres=%1"
    case movie = "3/movie/%1?api_key=%@&language=en-US"
    
    func apiURL(data: String? = "") -> String {
        let apiURL = Constants.Url.apiURL
        
        switch self {
        case .login:
            return "\(apiURL)\(Api.login.rawValue)\(Constants.ApiKeys.theMovieKey)"
        case .requestToken:
            return "\(apiURL)\(Api.requestToken.rawValue)\(Constants.ApiKeys.theMovieKey)"
        case .genre:
            return "\(apiURL)\(Api.genre.rawValue)".replacingOccurrences(of: "%@", with: Constants.ApiKeys.theMovieKey)
        case .movies:
            return "\(apiURL)\(Api.movies.rawValue)".replacingOccurrences(of: "%@", with: Constants.ApiKeys.theMovieKey).replacingOccurrences(of: "%1", with: data!)
        case .movie:
            return "\(apiURL)\(Api.movie.rawValue)".replacingOccurrences(of: "%@", with: Constants.ApiKeys.theMovieKey).replacingOccurrences(of: "%1", with: data!)
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .postMethod
        case .requestToken, .genre, .movies, .movie:
            return .getMethod
        }
    }
    
    enum Method: String {
        case postMethod = "POST"
        case getMethod = "GET"
        case putMethod = "PUT"
        case deleteMethod = "DELETE"
    }

}
