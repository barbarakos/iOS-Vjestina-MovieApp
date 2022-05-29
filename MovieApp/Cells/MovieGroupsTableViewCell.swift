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

    var mainView : UIView!
    var groupTitle : UILabel!
    var filterBarView : FilterTabCollectionView!
    var group : MovieGroupCollectionView!
    
    var groupType : GroupType!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        buildViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(groupType : GroupType) {
        self.groupType = groupType
        groupTitle.font = UIFont(name: "AvenirNext-Bold", size: 23)
        groupTitle.text = groupType.title
        group.setGroupType(group : groupType)
        group.allowsMultipleSelection = false
        filterBarView.setGroupType(group: groupType)
    }
    
    func setRouter(router: AppRouter) {
        self.router = router
        buildViews()
    }
    
    func buildViews() {
        createViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        mainView = UIView()
        contentView.addSubview(mainView)

        groupTitle = UILabel()
        mainView.addSubview(groupTitle)
        
        filterBarView = FilterTabCollectionView()
        contentView.addSubview(filterBarView)
       
        group = MovieGroupCollectionView()
        group.setRouter(router: router)
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
