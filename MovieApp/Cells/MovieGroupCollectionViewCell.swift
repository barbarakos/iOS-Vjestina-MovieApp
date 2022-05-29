//
//  MovieGroupCollectionViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 11.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupCollectionViewCell: UICollectionViewCell {
    
    private var repository : MoviesRepository!
    
    var mainView : UIView!
    var movieImage = UIImageView()
    var circleImage : UIImageView!
    var heartButton : UIButton!
    
    var urlString : String!
    var movie : Movie!
    
    var selectedFav: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovieAndRepo(movie : Movie, repository: MoviesRepository) {
        self.movie = movie
        movieImage.image = UIImage(data: movie.poster_path!)
        self.repository = repository
        selectedFav = movie.favorite
        buildViews()
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        
        mainView = UIView()
        addSubview(mainView)
        
        mainView.addSubview(movieImage)
        
        let circle = UIImage(systemName: "circle.fill")
        circleImage = UIImageView(image: circle)
        circleImage.tintColor = .black
        circleImage.layer.opacity = 0.5
        mainView.addSubview(circleImage)
        mainView.bringSubviewToFront(circleImage)
        circleImage.isUserInteractionEnabled = true
        
        heartButton = UIButton()
        heartButton.isUserInteractionEnabled = true
        if (selectedFav) {
            heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
        heartButton.tintColor = .white
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        circleImage.addSubview(heartButton)
        contentView.bringSubviewToFront(heartButton)
    }
    
    @objc func heartTapped() {
        if(selectedFav) {
            heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            selectedFav = false
        } else {
            heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            selectedFav = true
        }
        repository.changeFavoriteValue(movie: movie)
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
