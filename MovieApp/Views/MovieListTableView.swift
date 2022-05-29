//
//  MovieListTableView.swift
//  MovieApp
//
//  Created by Barbara Kos on 09.04.2022..
//

import UIKit
import MovieAppData
import CoreData

class MovieListTableView: UITableView {
    
    private var router : AppRouter!
    let viewModel = MovieViewModel()
    private var repository : MoviesRepository!
    let cellId = "cellId"
    
    var filteredMovies = [Movie]()
    var searchedText = ""

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
    }
    
    convenience init(router: AppRouter, repository: MoviesRepository) {
        self.init()
        self.router = router
        self.repository = repository
        
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
        getFilteredMovies()
    }
    
    func getFilteredMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchedText)
//        request.predicate = NSPredicate(format: "title LIKE %@", "B")
        repository.database.getAllMovies(fetchRequest: request)
        
        filteredMovies = repository.database.movies
        self.reloadData()
    }
    
    func setSearchedText(searchedText: String) {
        self.searchedText = searchedText
        getFilteredMovies()
    }
}

extension MovieListTableView : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = dequeueReusableCell(withIdentifier: cellId) as! MovieListTableViewCell
        let movie = filteredMovies[indexPath.row]
        cell.set(movie: movie)
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = filteredMovies[indexPath.row]
        router.setMovieAndRepo(movie: movie, repository: repository)
        router.showMovieDetailsController(num: 1)
    }
    
}
