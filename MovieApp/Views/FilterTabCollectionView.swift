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
    var cellId = "cellID"
    
    var groupType : GroupType!
    var lastIndexActive:IndexPath!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        super.init(frame: .zero, collectionViewLayout : layout)
        
        configure()
        
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
    
    func setGroupType(group : GroupType) {
        groupType = group
        loadGenres()
    }
    
    func loadGenres() {
        viewModel.fetchGenresData(for: groupType){ [weak self] in
            DispatchQueue.main.async {
                self?.delegate = self
                self?.reloadData()
            }
        }
        
    }

}

extension FilterTabCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfGenreItemsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FilterTabCollectionViewCell
        let filter = viewModel.cellForGenreItemAt(indexPath: indexPath)
        cell.setFilter(filter: filter)
        if (indexPath.row == 0 && lastIndexActive == nil) {
            cell.select(select : true)
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
    }
}

