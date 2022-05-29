//
//  SearchBarView.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import SnapKit

class SearchBarView: UIView {

    var grayView : UIView!
    var searchImage : UIImageView!
    var textField : UITextField!
    var xButton : UIButton!
    var cancelButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        grayView = UIView()
        self.addSubview(grayView)
        
        textField = UITextField()
        textField.returnKeyType = .done
        grayView.addSubview(textField)
        
        searchImage = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        grayView.addSubview(searchImage)
        
        xButton = UIButton()
        xButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        grayView.addSubview(xButton)
        xButton.addAction(.init{_ in
            self.textField.text = ""
        }, for: .touchUpInside)
        
        xButton.isHidden = true
        
        cancelButton = UIButton()
        self.addSubview(cancelButton)
        cancelButton.addAction(.init{_ in
            self.textField.text = ""
            self.textField.endEditing(true)
        }, for: .touchUpInside)
        cancelButton.isHidden = true
        
    }
    
    func styleViews() {
        grayView.backgroundColor = .systemGray5
        grayView.layer.cornerRadius = 10
        
        textField.backgroundColor = .clear
        textField.placeholder = "Search"
        
        searchImage.tintColor = .black
        searchImage.contentMode = .scaleAspectFill
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        
        xButton.tintColor = .black
    }
    
    func defineLayoutForViews() {
        grayView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        searchImage.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(10)
            $0.width.equalTo(searchImage.snp.height)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(7)
            $0.leading.equalTo(searchImage.snp.trailing).offset(10)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalTo(grayView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        xButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        grayView.snp.updateConstraints {
//            $0.top.bottom.trailing.leading.equalToSuperview().inset(10)
//            $0.trailing.equalToSuperview().inset(80)
//        }
//        
//        xButton.isHidden = false
//        cancelButton.isHidden = false
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        grayView.snp.updateConstraints {
//            $0.top.bottom.trailing.leading.equalToSuperview().inset(10)
//            $0.trailing.equalToSuperview().inset(10)
//        }
//        
//        xButton.isHidden = true
//        cancelButton.isHidden = true
//    }
    

}
