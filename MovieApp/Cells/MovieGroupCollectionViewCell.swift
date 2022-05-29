//
//  MovieGroupCollectionViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 11.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupCollectionViewCell: UICollectionViewCell {
    
    var mainView : UIView!
    var movieImage : UIImageView!
    var circleImage : UIImageView!
    var heartButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie : MovieModel) {
        guard let url = URL(string: movie.imageUrl) else {return}
        movieImage.image = UIImage(data: try! Data(contentsOf: url))
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        mainView = UIView()
        addSubview(mainView)
        
        movieImage = UIImageView()
        mainView.addSubview(movieImage)
        
        let circle = UIImage(systemName: "circle.fill")
        circleImage = UIImageView(image: circle)
        circleImage.tintColor = .black
        circleImage.layer.opacity = 0.5
        movieImage.addSubview(circleImage)
        
        heartButton = UIButton()
        heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .white
        circleImage.addSubview(heartButton)
    }
    
    func styleViews() {
        self.layer.cornerRadius = 15
        
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 15
        
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 15
        
    }
    
    func defineLayoutForViews() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        movieImage.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        circleImage.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(5)
            $0.trailing.equalTo(circleImage.snp.leading).inset(32)
            $0.bottom.equalTo(circleImage.snp.top).offset(32)
        }
        
        heartButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
