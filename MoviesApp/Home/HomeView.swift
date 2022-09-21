//
//
// HomeView.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 19/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var collCategory: UICollectionView!
    @IBOutlet weak var collMovie: UICollectionView!
    
    lazy var presenter: HomePresenterProtocol = HomePresenter(delegate: self)
    lazy var collCategoryManager = CollCategoryManager()
    lazy var collMovieManager = CollMovieManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButton()
        
        collCategory.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        collCategory.delegate = collCategoryManager
        collCategory.dataSource = collCategoryManager
        
        collMovie.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        collMovie.delegate = collMovieManager
        collMovie.dataSource = collMovieManager
      
        DispatchQueue.main.async {
            self.presenter.getGenres()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collMovie.reloadData()
    }
    
    private func addButton() {
        let image = UIImage(systemName: Constants.Images.menu)
        let backButton: UIBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    @objc func openMenu() {
        let alert = UIAlertController(title: .msgWhatDoYouWantToDo, message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: .lblViewProfile, style: .default, handler: { _ in
            self.goToProfileView()
        }))
        alert.addAction(UIAlertAction(title: .lblLogOut, style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: .Cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func goToProfileView() {
        let vc = ProfileView.getProfileView()
        self.present(vc, animated: true, completion: nil)
    }
}


extension HomeView: HomeProtocol {
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showError(_ message: String) {
        
    }
    
    func goToDetail(idMovie: Int, name: String) {
        DispatchQueue.main.async {
            let vc = DetailView.getDetailView(idMovie: idMovie, name: name)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadGenres() {
        DispatchQueue.main.async {
            self.collCategoryManager.setData(data: self.presenter.genres)
            self.collCategory.reloadData()
            self.setActionSelectedGenre()
        }
    }
    
    func reloadMovies(movies: [Movie]) {
        DispatchQueue.main.async {
            self.collMovieManager.setData(data: movies)
            self.collMovie.reloadData()
            self.setActionSelectedMovie()
        }
    }
    
    func setTitle(name: String) {
        DispatchQueue.main.async {
            self.title = name
        }        
    }
    
    private func setActionSelectedGenre() {
        self.collCategoryManager.selectedIndex = { index in
            self.presenter.getGenreByIndex(index)
        }
    }
    
    private func setActionSelectedMovie() {
        self.collMovieManager.selectedIndex = { idMovie, name in
            self.goToDetail(idMovie: idMovie, name: name)
        }
    }
    
    func reloadCollectionMovies() {
        DispatchQueue.main.async {
            self.collMovie.reloadData()
        }
    }
}
 


extension UIViewController {
    class func getViewController() -> UIViewController {
        let bundle = Bundle(for: HomeView.self)
        let view  = HomeView(nibName: "HomeView", bundle: bundle)
        return view        
    }
}
