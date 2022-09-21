//
//
// Profile.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 21/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class ProfileView: UIViewController {

    lazy var presenter: ProfilePresenterProtocol = ProfilePresenter(delegate: self)
    
    @IBOutlet weak var collFavorite: UICollectionView!
    @IBOutlet weak var stkFavorite: UIStackView!
    private lazy var collMovieManager = CollMovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialView()
        presenter.getMovieList()
    }
    
    private func initialView() {
        collFavorite.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        collFavorite.delegate = collMovieManager
        collFavorite.dataSource = collMovieManager
    }
}

extension ProfileView: ProfileProtocol {
   
    
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func showError(_ message: String) {
        simpleAlert(title: .Verify, message: message)
    }
    
    func hideSectionFavorites() {
        DispatchQueue.main.async {
            
        }
    }
    
    func reloadMovies(movies: [Movie]) {
        DispatchQueue.main.async {
            self.collMovieManager.setData(data: movies)
            self.collFavorite.reloadData()
        }
    }
}

extension UIViewController {
    class func getProfileView() -> UIViewController {
        let bundle = Bundle(for: HomeView.self)
        let view  = ProfileView(nibName: "ProfileView", bundle: bundle)
        
        return view
    }
}
