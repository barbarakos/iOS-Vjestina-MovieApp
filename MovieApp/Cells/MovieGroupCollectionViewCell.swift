//
//  MovieGroupCollectionViewCell.swift
//  MovieApp
//
//  Created by Barbara Kos on 11.04.2022..
//

import UIKit
import MovieAppData

class MovieGroupCollectionViewCell: UICollectionViewCell {
    
    let networkService = NetworkService()
    
    var mainView : UIView!
    var movieImage : UIImageView!
    var circleImage : UIImageView!
    var heartButton : UIButton!
    
    var urlString : String!
    var movie : Movie!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie : Movie) {
        let posterString = movie.poster_path
        urlString = "https://image.tmdb.org/t/p/original" + posterString
        guard let posterImageURL = URL(string: urlString) else {return}
        movieImage.image = nil
        
        DispatchQueue.global().async {
            self.networkService.getImageDataFrom(url: posterImageURL) { [weak self] (result) in
                    switch result {
                    case .success(let image):
                        self?.movieImage.image = image
                    case .failure(let error):
                        print("Error processing data: \(error)")

                    }
            }
        }
        
//        DispatchQueue.global().async {
//            do {
//                let data = try Data(contentsOf: posterImageURL)
//                DispatchQueue.main.async {
//                    self.movieImage.image = UIImage(data: data)
//                }
//            } catch {
//                print("Error with loading poster image: \(error.localizedDescription)")
//            }
//        }
//        movieImage.image = UIImage(data: try! Data(contentsOf: posterImageURL))
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
