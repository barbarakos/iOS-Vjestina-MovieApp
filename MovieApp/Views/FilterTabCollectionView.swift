//
//  FilterTabCollectionView.swift
//  MovieApp
//
//  Created by Barbara Kos on 11.04.2022..
//

import UIKit
import MovieAppData
import SnapKit

class FilterTabCollectionView: UICollectionView {

    private var viewModel = MovieViewModel()
    private var repository : MoviesRepository!
    var cellId = "cellID"
    
    
    var genres = [MovieGenre]()
    var lastIndexActive:IndexPath!
    @objc dynamic var currentGenre: MovieGenre!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        super.init(frame: .zero, collectionViewLayout : layout)
        
        configure()
        
    }
    convenience init(repository: MoviesRepository) {
        self.init()
        self.repository = repository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        register(FilterTabCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = .white
        allowsSelection = true
        allowsMultipleSelection = false
        delegate = self
        dataSource = self
    }
    
    func loadGenres() {
        repository.update()
        DispatchQueue.main.async {
            self.genres = self.repository.database.genres
            self.reloadData()
        }
        
    }

}

extension FilterTabCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterTabCollectionViewCell
        let filter = genres[indexPath.row]
        cell.setFilter(filter: filter)
        if (indexPath.row == 0 && lastIndexActive == nil) {
            cell.select(select : true)
            currentGenre = genres[indexPath.row]
            self.lastIndexActive = indexPath
        }
        cell.select(select : (indexPath == lastIndexActive))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.lastIndexActive != indexPath else {return}
        
        if let index = lastIndexActive {
            
            let cell = collectionView.cellForItem(at: index) as? FilterTabCollectionViewCell
            if cell != nil {
                cell?.select(select : false)
            }
        }
        let cell = collectionView.cellForItem(at: indexPath) as! FilterTabCollectionViewCell
        cell.select(select: true)
        lastIndexActive = indexPath
        currentGenre = genres[indexPath.row]
    }
}

