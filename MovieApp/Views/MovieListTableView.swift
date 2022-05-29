//
//  MovieListTableView.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData

class MovieListTableView: UITableView {
    
    let cellId = "cellId"
    var movies : [MovieModel] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        movies = Movies.all()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        delegate = self
        dataSource = self
        register(MovieListTableViewCell.self, forCellReuseIdentifier: cellId)
        rowHeight = 160
        separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
}

extension MovieListTableView : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = dequeueReusableCell(withIdentifier: cellId) as! MovieListTableViewCell
        let movie = movies[indexPath.row]
        cell.set(movie: movie)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
