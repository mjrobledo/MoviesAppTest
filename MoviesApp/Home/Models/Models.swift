//
//
// Models.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import Foundation

 

struct GenresResponse : Codable {
    let genres : [GenresModel]?
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}

struct GenresModel : Codable {
    
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - Movies

struct MovieResponse : Codable {
    let page : Int?
    let results : [Movie]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}


struct Movie : Codable {
    var adult : Bool?
    var backdrop_path : String?
    var genre_ids : [Int]?
    var id : Int?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Double?
    var poster_path : String?
    var release_date : String?
    var title : String?
    var video : Bool?
    var vote_average : Double?
    var vote_count : Int?
    var production_companies: [ProductionCompanies]?
    var status: String?
   
    
    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
        case production_companies = "production_companies"
        case status = "status"
    }
    
    init(id: Int, overview: String, poster_path: String, vote_average: Float, release_date: String ) {
        self.id = id
        self.overview = overview
        self.poster_path = poster_path
        self.vote_average = Double(vote_average)
        self.release_date = release_date
    }
    
    var urlImage: String {
        guard let poster_path = poster_path else {
            return ""
        }

        return "\(Constants.Url.apiImage)\(poster_path)"
    }
}


struct ProductionCompanies : Codable {
    
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }
    
    
    var urlImage: String {
        guard let logo_path = logo_path else {
            return ""
        }

        return "\(Constants.Url.apiImage)\(logo_path)"
    }
}
