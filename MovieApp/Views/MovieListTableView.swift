//
//  MovieListTableView.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData

class MovieListTableView: UITableView {
    
    private var router : AppRouter!
    let viewModel = MovieViewModel()
    
    let cellId = "cellId"

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configureTableView()
    }
    
    convenience init(router: AppRouter) {
        self.init()
        self.router = router
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
        loadAllMovies()
    }
    
    func loadAllMovies() {
        viewModel.fetchAllMovies() { [weak self] in
            DispatchQueue.main.async {
                self?.dataSource = self
                self?.reloadData()
            }
            
        }
    }
}

extension MovieListTableView : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfAllMoviesInSection(section: section)
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = dequeueReusableCell(withIdentifier: cellId) as! MovieListTableViewCell
        let movie = viewModel.cellForAllMoviesItemAt(indexPath: indexPath)
        cell.set(movie: movie)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.cellForAllMoviesItemAt(indexPath: indexPath)
        router.setMovie(movie : movie)
        router.showMovieDetailsController()
    }
    
}
