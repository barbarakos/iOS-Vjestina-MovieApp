//
//  FavoritesCollectionView.swift
//  MovieApp
//
//  Created by Barbara Kos on 29.05.2022..
//

import UIKit
import CoreData

class FavoritesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {

    private var router : AppRouter!
    private var repository : MoviesRepository!
    
    var favoriteMovies = [Movie]()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        super.init(frame: .zero, collectionViewLayout : layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(router: AppRouter, repository: MoviesRepository) {
        self.init()
        self.router = router
        self.repository = repository
        loadMovies()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        backgroundColor = .white
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsets(top: -10, left: 0, bottom:0, right: 0)
        self.isScrollEnabled = true
        self.isPagingEnabled = true
        self.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    
    func loadMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "favorite = true")
        repository.database.getAllMovies(fetchRequest: request)
        favoriteMovies = repository.database.movies
        print("BROJ FAVORITE FILMOVA")
        print(favoriteMovies.count)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension FavoritesCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 117, height: 173)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! FavoritesCollectionViewCell
        cell.layer.cornerRadius = 15
        let movie = favoriteMovies[indexPath.row]
        cell.setMovieAndRepo(movie: movie, repository: repository)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = favoriteMovies[indexPath.row]
        router.setMovieAndRepo(movie: movie, repository: repository)
        router.showMovieDetailsController(num: 2)
    }
}
