//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Barbara Kos on 30.03.2022..
//

import UIKit
import SnapKit

class MovieDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        buildViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func buildViews() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        view.addSubview(scrollView)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 345))
        headerView.backgroundColor = .white
        
        //Iron man.jpg
        let ironman = UIImageView()
        ironman.frame = headerView.frame
        let image = UIImage (named: "iron man.jpg")
        ironman.image = image
        ironman.contentMode = .scaleAspectFill
        ironman.clipsToBounds = true
        headerView.addSubview(ironman)
        scrollView.addSubview(headerView)
        
        //gradient
        let viewGradient = UIView(frame: headerView.frame)
        
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
        scrollView.addSubview(viewGradient)
        scrollView.bringSubviewToFront(viewGradient)
        
        
        //User score
        let userScore = UILabel()
        userScore.frame = CGRect(x: 0, y: 0, width: 72, height: 17)
        userScore.backgroundColor = .clear

        userScore.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        userScore.font = UIFont(name: "AvenirNext-Bold", size: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2

        userScore.attributedText = NSMutableAttributedString(string: "User Score",
                                attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])
        
        scrollView.addSubview(userScore)
        userScore.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top).offset(125)
            $0.left.equalTo(scrollView.snp.left).offset(72)
        }
        
        
        //circle
        let circle = UILabel()
        circle.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        circle.backgroundColor = .clear

        let percentageImage = UIImage(named: "download.png")?.cgImage
        let layer1 = CALayer()
        layer1.contents = percentageImage
        layer1.bounds = circle.bounds
        layer1.position = circle.center
        circle.layer.addSublayer(layer1)

        scrollView.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        circle.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(15)
            $0.top.equalTo(scrollView.snp.top).offset(113)
            
        }
        
        //76%
        let percentage = UILabel()
        percentage.frame = CGRect(x: 0, y: 0, width: 25, height: 16)
        percentage.backgroundColor = .clear

        percentage.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        percentage.font = UIFont(name: "AvenirNext-Bold", size: 17)
        paragraphStyle.lineHeightMultiple = 1.2

        percentage.attributedText = NSMutableAttributedString(string: "76%",
                                attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle])
        
        scrollView.addSubview(percentage)
        percentage.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(23)
            $0.top.equalTo(scrollView.snp.top).offset(123)
            
        }
        percentage.center = circle.center
    
        //Iron man
        let titleIronman = UILabel()
        titleIronman.backgroundColor = .clear

        titleIronman.textColor = UIColor(red: 0.951, green: 0.951, blue: 0.951, alpha: 1)
        titleIronman.font = UIFont(name: "AvenirNext-Bold", size: 29)
        paragraphStyle.lineHeightMultiple = 1.4
        
        titleIronman.attributedText = NSMutableAttributedString(string: "Iron man",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        scrollView.addSubview(titleIronman)
        
        titleIronman.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(11)
            $0.top.equalTo(scrollView.snp.top).offset(167)
            
        }

        //(2008)
        let titleYear = UILabel()
        titleYear.backgroundColor = .clear

        titleYear.textColor = UIColor(red: 0.951, green: 0.951, blue: 0.951, alpha: 1)
        titleYear.font = titleYear.font.withSize(28)
        paragraphStyle.lineHeightMultiple = 1.4
        
        titleYear.attributedText = NSMutableAttributedString(string: "(2008)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        scrollView.addSubview(titleYear)
        titleYear.snp.makeConstraints {
            $0.left.equalTo(titleIronman.snp.rightMargin).offset(14)
            $0.bottom.equalTo(titleIronman.snp.bottomMargin).offset(3)
            
        }
        
        //05/02/2008 (US) Action...
        let info = UILabel()
        //info.frame = CGRect(x: 0, y: 0, width: 258, height: 40)
        info.backgroundColor = .clear

        info.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        //info.font = UIFont(name: "Helvetica-Light", size: 17)
        info.font = UIFont.systemFont(ofSize: 17, weight: .light)
        //info.font = info.font.withSize(17)
        info.numberOfLines = 0
        info.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.2

        info.attributedText = NSMutableAttributedString(string: "05/02/2008 (US)\nAction, Science Fiction, Adventure",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        scrollView.addSubview(info)
        info.snp.makeConstraints {
            $0.left.equalTo(titleIronman.snp.left)
            $0.top.equalTo(titleIronman.snp.bottomMargin).offset(10)
            
        }

        //duration
        let duration = UILabel()
        duration.backgroundColor = .clear
        
        duration.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        duration.font = UIFont(name: "AvenirNext-Bold", size: 17)
        duration.numberOfLines = 0
        duration.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.2

        duration.attributedText = NSMutableAttributedString(string: "2h 6m",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        scrollView.addSubview(duration)
        duration.snp.makeConstraints {
            $0.left.equalTo(info.snp.right).offset(7)
            $0.bottom.equalTo(info.snp.bottom).offset(2)
            
        }
        
        //vector zvijezda
        let star = UILabel()
        star.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
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

        scrollView.addSubview(star)
        star.snp.makeConstraints {
            $0.left.equalTo(titleIronman.snp.left)
            $0.top.equalTo(info.snp.bottom).offset(20)
        }
        
        //Overview
        let overview = UILabel()
        overview.backgroundColor = .white
        overview.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 28)

        overview.textColor = UIColor(red: 0.043, green: 0.145, blue: 0.247, alpha: 1)
        overview.font = UIFont(name: "AvenirNext-Bold", size: 25)
        paragraphStyle.lineHeightMultiple = 1.4

        overview.attributedText = NSMutableAttributedString(string: "Overview",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        scrollView.addSubview(overview)
        overview.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            
        }
        
        //After being held captive...
        let description = UILabel()
        description.backgroundColor = .white

        description.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        description.font = UIFont(name: "AvenirNext-Regular", size: 16)
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping
        paragraphStyle.lineHeightMultiple = 1.15

        description.attributedText = NSMutableAttributedString(string: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        scrollView.addSubview(description)
        description.snp.makeConstraints {
            $0.trailing.equalTo(headerView.snp.trailing).offset(-27)
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(overview.snp.bottom).offset(6)
        }
        
        //CREW
        //Don Heck Characters
        let name1 = UILabel()
        let title1 = UILabel()
        name1.backgroundColor = .white
        title1.backgroundColor = .white
        name1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name1.font = UIFont(name: "AvenirNext-Bold", size: 16)
        paragraphStyle.lineHeightMultiple = 1.15

        name1.attributedText = NSMutableAttributedString(string: "Don Heck",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title1.font = UIFont(name: "AvenirNext-Regular", size: 16)

        title1.attributedText = NSMutableAttributedString(string: "Characters", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
  
        scrollView.addSubview(name1)
        scrollView.addSubview(title1)

        name1.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(description.snp.bottom).offset(22)
        }
        title1.snp.makeConstraints {
            $0.left.equalTo(scrollView.snp.left).offset(18)
            $0.top.equalTo(name1.snp.bottom)
        }


        //Jack Kirby Characters
        let name2 = UILabel()
        let title2 = UILabel()
        name2.backgroundColor = .white
        title2.backgroundColor = .white
        name2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name2.font = UIFont(name: "AvenirNext-Bold", size: 16)

        name2.attributedText = NSMutableAttributedString(string: "Jack Kirby",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title2.font = UIFont(name: "AvenirNext-Regular", size: 16)

        title2.attributedText = NSMutableAttributedString(string: "Characters", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        scrollView.addSubview(name2)
        scrollView.addSubview(title2)

        name2.snp.makeConstraints {
            $0.left.equalTo(title1.snp.right).offset(50)
            $0.top.equalTo(name1.snp.top)
        }
        title2.snp.makeConstraints {
            $0.left.equalTo(name2.snp.left)
            $0.top.equalTo(name2.snp.bottom)
        }

        //Jon Favreau Director
        let name3 = UILabel()
        let title3 = UILabel()
        name3.backgroundColor = .white
        title3.backgroundColor = .white
        name3.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name3.font = UIFont(name: "AvenirNext-Bold", size: 16)

        name3.attributedText = NSMutableAttributedString(string: "Jon Favreau",
                                 attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title3.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title3.font = UIFont(name: "AvenirNext-Regular", size: 16)
        title3.attributedText = NSMutableAttributedString(string: "Director", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
      
        scrollView.addSubview(name3)
        scrollView.addSubview(title3)

        name3.snp.makeConstraints {
             $0.left.equalTo(title2.snp.right).offset(55)
             $0.top.equalTo(name2.snp.top)
        }
        title3.snp.makeConstraints {
             $0.left.equalTo(name3.snp.left)
             $0.top.equalTo(name3.snp.bottom)
        }

        //Don Heck Screenplay
        let name4 = UILabel()
        let title4 = UILabel()
        name4.backgroundColor = .white
        title4.backgroundColor = .white
        name4.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name4.font = UIFont(name: "AvenirNext-Bold", size: 16)

        name4.attributedText = NSMutableAttributedString(string: "Don Heck",
                                attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title4.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title4.font = UIFont(name: "AvenirNext-Regular", size: 16)

        title4.attributedText = NSMutableAttributedString(string: "Screenplay", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        scrollView.addSubview(name4)
        scrollView.addSubview(title4)

        name4.snp.makeConstraints {
            $0.left.equalTo(title1.snp.left)
            $0.top.equalTo(title1.snp.bottom).offset(26)
        }
        title4.snp.makeConstraints {
            $0.left.equalTo(title1.snp.left)
            $0.top.equalTo(name4.snp.bottom)
        }

        //Jack Marcum Screenplay
        let name5 = UILabel()
        let title5 = UILabel()
        name5.backgroundColor = .white
        title5.backgroundColor = .white
        name5.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name5.font = UIFont(name: "AvenirNext-Bold", size: 16)

        name5.attributedText = NSMutableAttributedString(string: "Jack Marcum",
                                 attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title5.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title5.font = UIFont(name: "AvenirNext-Regular", size: 16)

        title5.attributedText = NSMutableAttributedString(string: "Screenplay", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
         
        scrollView.addSubview(name5)
        scrollView.addSubview(title5)
         
        name5.snp.makeConstraints {
             $0.left.equalTo(name2.snp.left)
             $0.top.equalTo(title2.snp.bottom).offset(26)
        }
        title5.snp.makeConstraints {
             $0.left.equalTo(name5.snp.left)
             $0.top.equalTo(name5.snp.bottom)
        }

        //Mat Holloway Screenplay
        let name6 = UILabel()
        let title6 = UILabel()
        name6.backgroundColor = .white
        title6.backgroundColor = .white
        name6.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name6.font = UIFont(name: "AvenirNext-Bold", size: 16)

        name6.attributedText = NSMutableAttributedString(string: "Mat Holloway",
                                 attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        title6.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title6.font = UIFont(name: "AvenirNext-Regular", size: 16)

        title6.attributedText = NSMutableAttributedString(string: "Screenplay", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
         
        scrollView.addSubview(name6)
        scrollView.addSubview(title6)
         
        name6.snp.makeConstraints {
             $0.left.equalTo(name3.snp.left)
            $0.top.equalTo(title3.snp.bottom).offset(26)
        }
        title6.snp.makeConstraints {
             $0.left.equalTo(name6.snp.left)
             $0.top.equalTo(name6.snp.bottom)
        }
        
    }
}
