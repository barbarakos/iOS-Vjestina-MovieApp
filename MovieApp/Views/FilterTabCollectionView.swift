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
    
    var filters : [FilterType] = []
    var cellId = "cellID"
    var filterButtons : [UIButton] = []
    let selectedAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont(name: "AvenirNext-Bold", size: 17)!,
          .underlineStyle: NSUnderlineStyle.thick.rawValue
//          .baselineOffset: 8
    ]
    let unselectedAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont(name: "AvenirNext-Regular", size: 17)!
//            .baselineOffset: 8
    ]
    
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
    
    func set(filters : [FilterType]) {
        self.filters = filters
        setFilters()
    }
    
    func setFilters() {
        for filter in filters {
            let filterTitle = UIButton()
            let attributeString = NSMutableAttributedString(
                string: filter.title,
                attributes: selectedAttributes
            )
            filterTitle.setAttributedTitle(attributeString, for: .normal)
            
            filterButtons.append(filterTitle)
        }
    }
    
    func configure() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        backgroundColor = .white
        delegate = self
        dataSource = self
    }

}

extension FilterTabCollectionView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        cell.contentView.addSubview(filterButtons[indexPath.row])
        if (indexPath.row == 0) {
            let attributeString = NSMutableAttributedString(
                string: (filterButtons[0].currentAttributedTitle?.string)!,
                    attributes: selectedAttributes
            )
//            let spacing = 1.5
//            let line = UIView()
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = .black
//            filterButtons[0].addSubview(line)
//            filterButtons[0].addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":line]))
//            filterButtons[0].addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(2)]-(\(-spacing))-|", metrics: nil, views: ["line":line]))
            filterButtons[indexPath.row].setAttributedTitle(attributeString, for: .normal)
        } else {
            let attributeString = NSMutableAttributedString(
                string: (filterButtons[indexPath.row].currentAttributedTitle?.string)!,
                    attributes: unselectedAttributes
            )
            filterButtons[indexPath.row].setAttributedTitle(attributeString, for: .normal)
        }
        
        filterButtons[indexPath.row].addAction(.init{_ in
            let attributeString = NSMutableAttributedString(
                string: (self.filterButtons[indexPath.row].currentAttributedTitle?.string)!,
                attributes: self.selectedAttributes
            )
//            let spacing = 1.5
//            let line = UIView()
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = .black
//            self.filterButtons[indexPath.row].addSubview(line)
//            self.filterButtons[indexPath.row].addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", metrics: nil, views: ["line":line]))
//            self.filterButtons[indexPath.row].addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(2)]-(\(-spacing))-|", metrics: nil, views: ["line":line]))
            self.filterButtons[indexPath.row].setAttributedTitle(attributeString, for: .normal)
            self.filterButtons[indexPath.row].snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.trailing.leading.equalToSuperview()
            }
            for id in 0..<self.filters.count {
                if (id != indexPath.row) {
                    let attributeString = NSMutableAttributedString(
                        string: (self.filterButtons[id].currentAttributedTitle?.string)!,
                        attributes: self.unselectedAttributes
                    )
                    self.filterButtons[id].setAttributedTitle(attributeString, for: .normal)
                    self.filterButtons[id].snp.makeConstraints {
                        $0.top.bottom.equalToSuperview()
                        $0.trailing.leading.equalToSuperview().inset(7)
                    }
//                    for view in self.filterButtons[id].subviews{
//                        if (view != self.filterButtons[id].currentAttributedTitle) {
//                            view.removeFromSuperview()
//                        }
//                    }
                }
                
            }
        }, for: .touchUpInside)
        
        filterButtons[indexPath.row].snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
        }
        
        return cell
    }
}

