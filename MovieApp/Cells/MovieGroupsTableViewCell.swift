//
//  MovieGroupsTableViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 10.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupsTableViewCell: UITableViewCell {
    
    private var router : AppRouter!
    private var repository: MoviesRepository!
    let cellId = "cellId"

    var mainView : UIView!
    var groupTitle : UILabel!
    var filterBarView : FilterTabCollectionView!
    var group : MovieGroupCollectionView!
    
    
    private var token: NSKeyValueObservation!
    
    var moviegroup : MovieGroup!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movieGroup : MovieGroup) {
        groupTitle.font = UIFont(name: "AvenirNext-Bold", size: 23)
        groupTitle.text = movieGroup.name
        group.setMovieGroup(group: movieGroup)
        group.allowsMultipleSelection = false
        filterBarView.loadGenres()
    }
    
    func setRouterAndRepo(router: AppRouter, repository: MoviesRepository) {
        self.router = router
        self.repository = repository
        buildViews()
    }
    
    func buildViews() {
        createViews()
        configure()
        defineLayoutForViews()
    }
    
    func configure() {
        token = filterBarView.observe(\.currentGenre, changeHandler: { (filterBarView, change) in
            print("Current genre is now set: \(filterBarView.currentGenre.name!)")
            self.group.setSelectedGenre(genre: filterBarView.currentGenre)
        })
    }
    
    func createViews() {
        mainView = UIView()
        contentView.addSubview(mainView)

        groupTitle = UILabel()
        mainView.addSubview(groupTitle)
        
        filterBarView = FilterTabCollectionView(repository: repository)
        contentView.addSubview(filterBarView)
       
        group = MovieGroupCollectionView(router: router, repository: repository)
        contentView.addSubview(group)
        
    }
    
    func defineLayoutForViews() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
        groupTitle.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(8)
            $0.bottom.equalTo(groupTitle.snp.top).offset(28)
        }
        
        filterBarView.snp.makeConstraints {
            $0.top.equalTo(groupTitle.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalTo(filterBarView.snp.top).offset(45)
        }
        
        group.snp.makeConstraints {
            $0.top.equalTo(filterBarView.snp.bottom).offset(18)
            $0.leading.trailing.bottom.equalToSuperview().inset(18)
            $0.bottom.equalTo(group.snp.top).offset(190)
        }
    }

}
