//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Barbara Kos on 31.03.2022..
//

import UIKit
import SnapKit

class MovieListViewController: UIViewController, UITextFieldDelegate {
    
    private var router: AppRouter!

    var searchbar : SearchBarView!
    var movieList : MovieListTableView!
    var movieGroups : MovieGroupsTableView!
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        buildViews()
    }
    
    func buildViews() {
        createViews()
        defineLayoutForViews()
    }
    
    func createViews() {
        searchbar = SearchBarView()
        view.addSubview(searchbar)
        searchbar.backgroundColor = .white
        searchbar.textField.delegate = self
        
        movieList = MovieListTableView(router : router)
        view.addSubview(movieList)
        movieList.isHidden = true
        
        movieGroups = MovieGroupsTableView(router : router)
//        movieGroups.setRouter(router: router)
        view.addSubview(movieGroups);
        view.bringSubviewToFront(movieGroups);
    }
    
    func defineLayoutForViews() {
        searchbar.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.size.equalTo(CGSize(width: self.view.frame.width, height: 70))
        }
        
        movieList.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(searchbar.snp.bottom).offset(15)
        }
        
        movieGroups.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.top.equalTo(searchbar.snp.bottom).offset(10)
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchbar.grayView.snp.updateConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(80)
        }
        
        movieGroups.isHidden = true
        movieList.isHidden = false
        searchbar.xButton.isHidden = false
        searchbar.cancelButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchbar.grayView.snp.updateConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        movieGroups.isHidden = false
        searchbar.xButton.isHidden = true
        searchbar.cancelButton.isHidden = true
        movieList.isHidden = true
    }
    

}
