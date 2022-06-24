//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Barbara Kos on 30.03.2022..
//

import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {
    
    private var router : AppRouter!
    private var repository : MoviesRepository!
    private var viewModel = MovieViewModel()
    var detmovie : Movie!
    
    var scrollView : UIScrollView!
    var contentView : UIView!
    var headerView : UIView!
    var posterImage : UIImageView!
    var viewGradient : UIView!
    var star : UILabel!
    var genresLabel : UILabel!
    var dateLabel : UILabel!
    var titleLabel : UILabel!
    var userScore : UILabel!
    var overview : UILabel!
    var descriptionLabel : UILabel!
    var percentage : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"))
        let tmdb = UIImageView()
        let image = UIImage (named: "tmdb.jpg")
        tmdb.image = image
        tmdb.contentMode = .scaleAspectFit
        navigationItem.titleView = tmdb
    }
    
    convenience init(router: AppRouter, repository: MoviesRepository) {
        self.init()
        self.router = router
        self.repository = repository
    }
    
    func setMovie(movie : Movie) {
        detmovie = movie
        buildViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // inicijalna transformacija izvan ekrana
        titleLabel.transform = titleLabel.transform.translatedBy(x: view.frame.width, y: 0)
        dateLabel.transform = dateLabel.transform.translatedBy(x: view.frame.width, y: 0)
        genresLabel.transform = genresLabel.transform.translatedBy(x: view.frame.width, y: 0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(
            withDuration: 1,
            animations: {
                self.titleLabel.transform = .identity
            }
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 0.5,
            animations: {
                self.dateLabel.transform = .identity
            }
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 0.75,
            options: [.curveEaseIn, .curveEaseOut],
            animations: {
                self.genresLabel.transform = .identity
            }
        )
    }
    
    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = CGSize(width: view.frame.width, height: 1000)
        scrollView.addSubview(contentView)
        
        headerView = UIView()
        headerView.frame.size = CGSize(width: view.frame.width, height: 370)
        contentView.addSubview(headerView)
        
        posterImage = UIImageView()
        headerView.addSubview(posterImage)
        
        viewGradient = UIView(frame: headerView.frame)
        headerView.addSubview(viewGradient)
        headerView.bringSubviewToFront(viewGradient)
        
        star = UILabel()
        star.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        headerView.addSubview(star)
        
        genresLabel = UILabel()
        headerView.addSubview(genresLabel)
        
        dateLabel = UILabel()
        headerView.addSubview(dateLabel)
        
        titleLabel = UILabel()
        headerView.addSubview(titleLabel)
        
        userScore = UILabel()
        headerView.addSubview(userScore)
        
        overview = UILabel()
        contentView.addSubview(overview)
        
        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)
        
        percentage = UILabel()
        percentage.frame = CGRect(x: 0, y: 0, width: 25, height: 16)
        headerView.addSubview(percentage)
    }
    
    func styleViews() {
        //image
        posterImage.image = UIImage(data: detmovie.poster_path!)
        posterImage.frame = headerView.frame
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        //gradient
        let gradient = CAGradientLayer()
        gradient.frame = viewGradient.frame
        gradient.colors = [
          UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor,
          UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        ]
        gradient.bounds = viewGradient.bounds.insetBy(dx: -0.1*viewGradient.bounds.size.width, dy: -0.1*viewGradient.bounds.size.height)
        gradient.frame = viewGradient.frame
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        viewGradient.layer.insertSublayer(gradient, at: 0)
        
        //star
        star.backgroundColor = .clear
        let elipse = UIImage(named: "Elipse")?.cgImage
        let layer2 = CALayer()
        layer2.contents = elipse
        layer2.bounds = star.bounds
        layer2.position = star.center
        let starImage = UIImage(named: "Star")?.cgImage
        let layer3 = CALayer()
        layer3.contents = starImage
        layer3.bounds = star.bounds
        layer3.frame = CGRect(x: 0, y:0, width: 15, height: 15)
        layer3.position = star.center
        star.layer.addSublayer(layer2)
        star.layer.addSublayer(layer3)
        
        //genres
        genresLabel.textColor = .white
        genresLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        genresLabel.numberOfLines = 0
        genresLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        var genresString = ""
        let genres = detmovie.genres
        genresString = genres![0].name!
        for index in genres!.indices {
            if index != 0 {
                genresString = genresString + ", \(genres![index].name!)"
            }
        }
//        let movieDurationHours : Int = (detmovie.runtime / 60)
//        let movieDurationMins = detmovie.runtime - (movieDurationHours*60)
        genresLabel.attributedText = NSMutableAttributedString(string: genresString,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        //release date
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        dateLabel.attributedText = NSMutableAttributedString(string: convertDateFormatter(_: detmovie.release_date),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        //title
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = UIColor(red: 0.951, green: 0.951, blue: 0.951, alpha: 1)
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 29)
        titleLabel.numberOfLines = 0
        paragraphStyle.lineHeightMultiple = 1.2
        let dateArr = detmovie.release_date!.components(separatedBy: "-")
        titleLabel.attributedText = NSMutableAttributedString(string: detmovie.title! + "  (\(dateArr[0]))",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            
        //userscore label
        userScore.frame = CGRect(x: 0, y: 0, width: 72, height: 17)
        userScore.backgroundColor = .clear

        userScore.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        userScore.font = UIFont(name: "AvenirNext-Bold", size: 17)
    

        userScore.attributedText = NSMutableAttributedString(string: "User Score",
                                attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])
        
        //overview title
        overview.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        overview.font = UIFont(name: "AvenirNext-Bold", size: 25)
        paragraphStyle.lineHeightMultiple = 1.4

        overview.attributedText = NSMutableAttributedString(string: "Overview",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        //overview description
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.15
        descriptionLabel.attributedText = NSMutableAttributedString(string: detmovie.overview!, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        //percentage
        let ratePercentage = Int(detmovie.vote_average * 10)
        percentage.backgroundColor = .clear
        percentage.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        percentage.font = UIFont(name: "AvenirNext-Bold", size: 17)
        paragraphStyle.lineHeightMultiple = 1.2
        percentage.attributedText = NSMutableAttributedString(string: "\(ratePercentage)%",
                                attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])


    }
    
    func defineLayoutForViews() {
        posterImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        star.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(25)
            $0.top.equalTo(star.snp.bottom).inset(38)
        }
        
        genresLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(star.snp.top).offset(-55)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(genresLabel.snp.top).offset(-25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(dateLabel.snp.top).offset(-10)
            $0.top.equalTo(userScore.snp.bottom).offset(10)
        }
        
        userScore.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().offset(24)
            $0.left.equalToSuperview().offset(72)
        }
        
        overview.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.trailing.equalTo(headerView.snp.trailing).offset(-27)
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(overview.snp.bottom).offset(6)
        }
        
        percentage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(23)
            $0.top.equalTo(userScore.snp.top)

        }
    }
    
//    func buildViews1() {
        //circle
//        let circle = UILabel()
//        circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        headerView.addSubview(circle)
//        circle.snp.makeConstraints {
//            $0.left.equalToSuperview().offset(23)
//            $0.top.equalToSuperview().offset(60)
//
//        }
        
//        let layer = CAShapeLayer()
//        let path = UIBezierPath(arcCenter: circle.center, radius: 10, startAngle: -CGFloat.pi / 2, endAngle:  2 * CGFloat.pi, clockwise: true)
//        layer.path = path.cgPath
//        layer.strokeColor = UIColor.green.cgColor
//        layer.fillColor = UIColor.clear.cgColor
//        layer.lineWidth = 3
//        layer.lineCap = CAShapeLayerLineCap.round
//        layer.strokeEnd = CGFloat(ratePercentage/100) * 2 * CGFloat.pi
//        circle.layer.addSublayer(layer)
//
        //duration
//        let duration = UILabel()
//        duration.backgroundColor = .clear
//
//        duration.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
//        duration.font = UIFont(name: "AvenirNext-Bold", size: 17)
//        duration.numberOfLines = 0
//        duration.lineBreakMode = .byWordWrapping
//        paragraphStyle.lineHeightMultiple = 1.2
//        let movieDurationHours : Int = (detmovie.runtime / 60)
//        let movieDurationMins = detmovie.runtime - (movieDurationHours*60)
//        let movieDuration : String = "\(movieDurationHours)h" + " \(movieDurationMins)min"
//        duration.attributedText = NSMutableAttributedString(string: movieDuration,
//            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
//
//        headerView.addSubview(duration)
//        duration.snp.makeConstraints {
//            $0.trailing.leading.equalToSuperview().offset(20)
//            $0.top.equalTo(genresLabel.snp.bottomMargin).offset(10)
//
//        }
//    }
    
    func convertDateFormatter(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
