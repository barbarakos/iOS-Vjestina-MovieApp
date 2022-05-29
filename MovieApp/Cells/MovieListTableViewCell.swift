//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData

class MovieListTableViewCell: UITableViewCell {
    
    var mainView : UIView!
    var posterImage : UIImageView!
    var movieTitle : UILabel!
    var movieDescription : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie : MovieModel) {
        guard let url = URL(string: movie.imageUrl) else {return}
        posterImage.image = UIImage(data: try! Data(contentsOf: url))

        movieTitle.font = UIFont(name: "AvenirNext-Bold", size: 16)
        movieTitle.text = movie.title

        movieDescription.font = UIFont(name: "AvenirNext-Regular", size: 14)
        movieDescription.text = movie.description
        
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        mainView = UIView()
        addSubview(mainView)
        
        posterImage = UIImageView()
        mainView.addSubview(posterImage)

        movieTitle = UILabel()
        mainView.addSubview(movieTitle)

        movieDescription = UILabel()
        mainView.addSubview(movieDescription)
        
    }
    
    func styleViews() {
        mainView.backgroundColor = .white
        mainView.layer.shadowOffset = CGSize(width: 10, height: 10)
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.cornerRadius = 15
        
        posterImage.contentMode = .scaleAspectFit
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 15
        
        
        movieTitle.numberOfLines = 0
        movieTitle.lineBreakMode = .byWordWrapping

        movieDescription.numberOfLines = 0
        
    }
    
    func defineLayoutForViews() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(15)
            $0.top.equalTo(mainView.snp.bottom).inset(142)
        }
        
        posterImage.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.trailing.equalTo(mainView.snp.leading).inset(97)
            $0.width.equalTo(97)
            $0.height.equalTo(142)
        }

        movieTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(posterImage.snp.trailing).offset(17)
            $0.trailing.equalToSuperview().inset(7)
        }

        movieDescription.snp.makeConstraints {
            $0.leading.trailing.equalTo(movieTitle)
            $0.top.equalTo(movieTitle.snp.bottom).offset(7)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
}
