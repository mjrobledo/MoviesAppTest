//
//
// LocalManager.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit
import CoreData

class LocalManager  {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
    func getMovies() -> [MovieLocal] {
        let noteFetch: NSFetchRequest<MovieLocal> = MovieLocal.fetchRequest()
        
        do {
            let managedContext = self.managedContext
            let results = try managedContext.fetch(noteFetch)
            return results
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        
        return []
    }
    
    func saveMovie(_ movie: Movie) {
        let managedContext = self.managedContext
        let movieL = MovieLocal(context: managedContext)
        
        var companiesString = ""
        if let companies = movie.production_companies {
           let names = companies.map({ $0.name ?? "" })
            companiesString = names.joined(separator: ",")
        }
        
        movieL.setValue(movie.id, forKey: #keyPath(MovieLocal.idMovie))
        movieL.setValue(movie.overview, forKey: #keyPath(MovieLocal.overview))
        movieL.setValue(movie.popularity, forKey: #keyPath(MovieLocal.popularity))
        movieL.setValue(movie.poster_path, forKey: #keyPath(MovieLocal.poster_path))
        movieL.setValue(companiesString, forKey: #keyPath(MovieLocal.production_companies))
        movieL.setValue(movie.release_date, forKey: #keyPath(MovieLocal.release_date))
        movieL.setValue(movie.status, forKey: #keyPath(MovieLocal.status))
        movieL.setValue(movie.vote_average, forKey: #keyPath(MovieLocal.vote_average))
                
        self.saveContext()
    }
    
    func getListIDMovie() -> [Int] {
        let movies: [MovieLocal] = self.getMovies()
        let moviesList = movies.map( { Int($0.idMovie) })
        return moviesList
    }
    
    func removeMovie(idMovie: Int) {
        let movie = getMovies().first(where: { $0.idMovie == Int64(idMovie) })
        if movie != nil {
            self.managedContext.delete(movie!)
            self.saveContext()
        }
    }
}
