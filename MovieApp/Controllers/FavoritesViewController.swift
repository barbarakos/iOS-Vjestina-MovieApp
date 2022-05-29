//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Barbara Kos on 26.04.2022..
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    private var router: AppRouter!
    var repository : MoviesRepository!
    var favoriteMovies = [Movie]()
    
    var mainView : UIView!
    var titleLabel : UILabel!
    var favoritesCollectionView : FavoritesCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        let navBarAppearance = UINavigationBarAppearance()
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
//        navBarAppearance.backgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//
//        let tmdb = UIImageView()
//        let image = UIImage (named: "tmdb.jpg")
//        tmdb.image = image
//        tmdb.contentMode = .scaleAspectFit
//        navigationItem.titleView = tmdb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoritesCollectionView!.loadMovies()
    }
    
    convenience init(router: AppRouter, repository: MoviesRepository) {
        self.init()
        self.router = router
        self.repository = repository
        
        buildViews()
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        
        mainView = UIView()
        view.addSubview(mainView)

        titleLabel = UILabel()
        mainView.addSubview(titleLabel)
        
        favoritesCollectionView = FavoritesCollectionView(router: router, repository: repository)
        favoritesCollectionView.reloadData()
        mainView.addSubview(favoritesCollectionView)
        
        
    }
    
    func styleViews() {
        mainView.isOpaque = false
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 23)
        titleLabel.text = "Favorites"
        
        
    }
    
    func defineLayoutForViews() {
        mainView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(25)
            $0.bottom.equalTo(titleLabel.snp.top).offset(28)
        }
        
        favoritesCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview()
        }
    }

}
