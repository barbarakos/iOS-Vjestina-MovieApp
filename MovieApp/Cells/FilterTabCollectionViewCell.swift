//
//  FilterTabCollectionViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 05.05.2022..
//

import UIKit

class FilterTabCollectionViewCell: UICollectionViewCell {
    
    var filterLabel = UILabel()
    var filter : Genre!
    var attributeStringSel : NSMutableAttributedString!
    var attributeStringUnsel : NSMutableAttributedString!
    
    let selectedAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont(name: "AvenirNext-Bold", size: 17)!,
          .underlineStyle: NSUnderlineStyle.thick.rawValue,
          .baselineOffset: 3
    ]
    let unselectedAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont(name: "AvenirNext-Regular", size: 17)!,
            .baselineOffset: 3
    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(select : Bool) {
        if (select) {
            filterLabel.attributedText = attributeStringSel
        } else {
            filterLabel.attributedText = attributeStringUnsel
        }
    }
    
    func buildViews() {
        createViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        attributeStringSel = NSMutableAttributedString(
            string: filter.name,
            attributes: selectedAttributes
        )
        
        attributeStringUnsel = NSMutableAttributedString(
            string: filter.name,
            attributes: unselectedAttributes
        )
        filterLabel.attributedText = attributeStringUnsel
        filterLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(filterLabel)
        
        
    }
    
    func defineLayoutForViews() {
        filterLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
        }
    }
    
    func setFilter(filter : Genre) {
        self.filter = filter
        buildViews()
    }
    
}

