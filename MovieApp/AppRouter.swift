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

    private var navController: UINavigationController!
    
    let tabBarController : UITabBarController!
    var movie : Movie!
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
        tabBarController = UITabBarController()
        
        
        self.setTabBarAndNavigationControllers()
        self.editNavigationBarItems(navigationController : navController)
    }
    
    func setTabBarAndNavigationControllers() {
        let movieList = MovieListViewController(router : self)
        self.navController = UINavigationController(rootViewController: movieList)
        navController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let favorites = FavoritesViewController()
        let navigationController2 = UINavigationController(rootViewController: favorites)
        navigationController2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = [navController, navigationController2]
    }
    
    func editNavigationBarItems(navigationController : UINavigationController) {
        let navBarAppearance = UINavigationBarAppearance()
//        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func showMovieDetailsController() {
        let vc = MovieDetailsViewController(router: self);
        vc.setMovie(movie : movie)
        navController.pushViewController(vc, animated: true)
    }
    
    func setMovie(movie : Movie) {
        self.movie = movie
    }
}
