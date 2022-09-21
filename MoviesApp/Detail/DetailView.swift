//
//
// DetailView.swift
// MoviesApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 20/09/22.
// Copyright (c) 2022 and Confidential to Personal All rights reserved.
//


import UIKit

class DetailView: UIViewController {
    
    @IBOutlet weak var collCompany: UICollectionView!
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblRelaseDate: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    
    private var barButton: UIBarButtonItem?
    
    var idMovie: Int?
    lazy var presenter: DetailPresenterProtocol = DetailPresenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialView()
        self.getServiceMovie()
    }
    
    private func initialView() {
         
        collCompany.register(UINib(nibName: "CompanyCell", bundle: nil), forCellWithReuseIdentifier: "companyCell")
        collCompany.delegate = self
        collCompany.dataSource = self
        
    }
    
    
    private func getServiceMovie() {
        guard let idMovie = idMovie else {
            return
        }

        DispatchQueue.main.async {
            self.presenter.getMovieById(idMovie)
        }
    }
    
    private func addButton() {
        var image = UIImage(systemName: Constants.Images.favorite)
        
        let favorite = presenter.getFavorite()
        
        if favorite {
            image = UIImage(systemName: Constants.Images.favoriteFill)
        }
        
        barButton = UIBarButtonItem(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector( actionBarButton))
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func actionBarButton() {
        if presenter.getFavorite() {
            self.removeFavorite()
        } else  {
            self.saveFavorite()
        }
    }
    
    private func removeFavorite() {
        presenter.removeFavorite()
        barButton?.image =  UIImage(systemName: Constants.Images.favorite)
    }
    
    private func saveFavorite() {
        presenter.saveMovie()
        barButton?.image =  UIImage(systemName: Constants.Images.favoriteFill)
    }
}

extension DetailView: DetailProtocol {
    func hideLoader() {
        self.hideIndicator()
    }
    
    func showLoader() {
        self.showIndicator()
    }
    
    func showError(_ message: String) {
        simpleAlert(title: .Verify, message: message)
    }
    
    func setDataMovie() {
        guard let movie = presenter.movie else {
            return
        }
        if !movie.urlImage.isEmpty {
            imgMovie.imageFromServerUrl(urlString: movie.urlImage, placeholder: UIImage())
        }
        lblOverview.text = movie.overview
        lblLanguage.text = movie.original_language
        lblPopularity.text = movie.popularity?.description
        lblStatus.text = movie.status
        lblRelaseDate.text = movie.release_date
        lblVote.text = movie.vote_average?.description
        
        collCompany.reloadData()
        
        self.addButton()
    }
    
}

extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movie?.production_companies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCell
        if let item = presenter.movie?.production_companies?[indexPath.row] {
            cell.imgCompany.imageFromServerUrl(urlString: item.urlImage, placeholder: UIImage())
        }
        return cell
    }
    
}

extension DetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 3) // 15 because of paddings
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
}


extension UIViewController {
    class func getDetailView(idMovie: Int, name: String) -> UIViewController {
        let bundle = Bundle(for: HomeView.self)
        let view  = DetailView(nibName: "DetailView", bundle: bundle)
        view.idMovie = idMovie
        view.title = name
        return view
    }
}
