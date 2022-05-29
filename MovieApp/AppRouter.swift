//
//  AppRouter.swift
//  MovieApp
//
//  Created by Barbara Kos on 04.05.2022..
//

import UIKit

protocol AppRouterProtocol {
    func setStartScreen(in window: UIWindow?)
}

class AppRouter : AppRouterProtocol {

    private var navController1: UINavigationController!
    private var navController2: UINavigationController!
    
    let tabBarController : UITabBarController!
    var movie : Movie!
    var repository: MoviesRepository!
    
    init(navigationController: UINavigationController) {
        tabBarController = UITabBarController()
        
        
        self.setTabBarAndNavigationControllers()
        self.editNavigationBarItems(navigationController : navController1)
        self.editNavigationBarItems(navigationController : navController2)
    }
    
    func setTabBarAndNavigationControllers() {
        let movieList = MovieListViewController(router : self)
        self.navController1 = UINavigationController(rootViewController: movieList)
        navController1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let favorites = FavoritesViewController(router : self, repository: movieList.repository)
        self.navController2 = UINavigationController(rootViewController: favorites)
        navController2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [navController1, navController2]
    }
    
    func editNavigationBarItems(navigationController : UINavigationController) {
        let navBarAppearance = UINavigationBarAppearance()
        navigationController.navigationBar.isTranslucent = false
        navBarAppearance.backgroundColor = UIColor(red: 11/255, green: 37/255, blue: 63/255, alpha: 1)
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance

        let tmdb = UIImageView()
        let image = UIImage (named: "tmdb.jpg")
        tmdb.image = image
        tmdb.contentMode = .scaleAspectFit
//        navigationController.navigationItem.titleView = tmdb
        navigationController.navigationBar.topItem?.titleView = tmdb
        navigationController.navigationBar.tintColor = .white
        
    }
    
    func setStartScreen(in window: UIWindow?) {
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func showMovieDetailsController(num : Int) {
        let vc = MovieDetailsViewController(router: self, repository: repository);
        vc.setMovie(movie : movie)
        if (num == 1) {
            navController1.pushViewController(vc, animated: true)
        } else {
            navController2.pushViewController(vc, animated: true)
        }
    }
    
    func setMovieAndRepo(movie : Movie, repository: MoviesRepository) {
        self.movie = movie
        self.repository = repository
    }
}
