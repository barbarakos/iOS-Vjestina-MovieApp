//
//  MovieGroupsTableViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 10.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupsTableViewCell: UITableViewCell {

    var mainView : UIView!
    var groupTitle : UILabel!
    var filters : [FilterType] = []
//    var filterBarView : FilterTabView!
    var filterBarView : UIView!
    var group : MovieGroupCollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(groupType : GroupType) {
        groupTitle.font = UIFont(name: "AvenirNext-Bold", size: 23)
        groupTitle.text = groupType.title
        
        filters = groupType.filters
//        filterBarView.set(filters: filters)
        
        group.setGroupType(group : groupType)
        
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        mainView = UIView()
        addSubview(mainView)

        groupTitle = UILabel()
        mainView.addSubview(groupTitle)
        
//        filterBarView = FilterTabView()
        filterBarView = UIView()
        filterBarView.backgroundColor = .systemGray5
        mainView.addSubview(filterBarView)
       
        group = MovieGroupCollectionView()
        contentView.addSubview(group)
        
    }
    
    func styleViews() {
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
            $0.top.equalTo(groupTitle.snp.bottom).offset(10)
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
