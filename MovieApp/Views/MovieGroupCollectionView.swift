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
    private var viewModel = MovieViewModel()
    
    var cellId = "cellID"
    var groupType : GroupType!

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        super.init(frame: .zero, collectionViewLayout : layout)
        
        configureCollectionView()
    }
    
    func setRouter(router: AppRouter) {
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func loadMoviesData() {
        viewModel.fetchMoviesData(for: groupType) { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
            }
            
        }
    }
    
    func loadGenres() {
        viewModel.fetchGenresData(for: groupType){ [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
            }
            
        }
    }
    
    func setGroupType(group : GroupType) {
        groupType = group
        loadGenres()
        loadMoviesData()
    }
    
    
}

extension MovieGroupCollectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 182)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(for: groupType, section: section)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieGroupCollectionViewCell
        cell.layer.cornerRadius = 15
        
        let movie = self.viewModel.cellForItemAt(for: self.groupType, indexPath: indexPath)
        cell.set(movie : movie)
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.cellForItemAt(for: groupType, indexPath: indexPath)
        router.setMovie(movie : movie)
        router.showMovieDetailsController()
    }
}
