//
//  FilterTabView.swift
//  MovieApp
//
//  Created by Barbara Kos on 11.04.2022..
//

import UIKit
import MovieAppData

class FilterTabView: UIView {
    
    var mainView : UIStackView!
    var filterLabels : [UILabel] = []
    var filters : [FilterType] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(filters : [FilterType]) {
        self.filters = filters
        
        setFilters()
        
    }
    
    func setFilters() {
        for filter in filters {
            let filterTitle = UILabel()
            filterTitle.font = UIFont(name: "AvenirNext-Bold", size: 16)
            filterTitle.text = filter.title
            filterTitle.textAlignment = .center
//            let filterView = UIView()
//            filterView.addSubview(filterTitle)
            filterLabels.append(filterTitle)
            mainView.addArrangedSubview(filterTitle)
        }
    }
    
    func configure() {
        buildViews()
    }
    
    func buildViews() {
        mainView = UIStackView()
        mainView.axis = .horizontal
        mainView.alignment = .fill
        mainView.distribution = .fillProportionally
        mainView.spacing = 20
        self.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.trailing.top.bottom.leading.equalToSuperview()
        }
        
    }
    
    

}
