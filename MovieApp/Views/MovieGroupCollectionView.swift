//
//  MovieGroupCollectionView.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout  {
    
    private var router : AppRouter!
    private var repository : MoviesRepository!
    
    var cellId = "cellID"
    var movieGroup : MovieGroup!
    
    var genreFilter: MovieGenre!
    var moviesInGroup = [Movie]()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        super.init(frame: .zero, collectionViewLayout : layout)
        
        self.configureCollectionView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(router: AppRouter, repository: MoviesRepository) {
        self.init()
        self.router = router
        self.repository = repository
    }
    
    func configureCollectionView() {
        register(MovieGroupCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = .white
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsets(top: -10, left: 0, bottom:0, right: 0)
        self.isScrollEnabled = true
        self.isPagingEnabled = true
        self.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    
    func loadMovies() {
        repository.update()
        self.moviesInGroup = movieGroup.movies!.filter { $0.genre_ids!.contains(Int(genreFilter.id)) }
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func setMovieGroup(group : MovieGroup) {
        movieGroup = group
    }
    
    func setSelectedGenre(genre: MovieGenre) {
        genreFilter = genre
        loadMovies()
    }
    
    
}

extension MovieGroupCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 182)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesInGroup.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieGroupCollectionViewCell
        cell.layer.cornerRadius = 15
        let movie = moviesInGroup[indexPath.row]
//        let movie = self.viewModel.cellForItemAt(for: self.groupType, indexPath: indexPath)
        cell.setMovieAndRepo(movie: movie, repository: repository)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = moviesInGroup[indexPath.row]
        router.setMovieAndRepo(movie: movie, repository: repository)
        router.showMovieDetailsController(num : 1)
    }
}
