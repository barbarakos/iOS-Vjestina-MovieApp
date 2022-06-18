//
//  NetworkService.swift
//  MovieApp
//
//  Created by Barbara Kos on 04.05.2022..
//

import UIKit

protocol NetworkServiceProtocol {
//    generic parameter 'T' could not be inferred & Cannot explicitly specialize a generic function
//    func executeMovieUrlRequest<T : Decodable>(for endUrl: String, completionHandler: @escaping (Result<T, RequestError>) -> Void)
    func executeMovieUrlRequest(for endUrl: String, completionHandler: @escaping (Result<MoviesData, RequestError>) -> Void)
    func executeGenresUrlRequest(completionHandler: @escaping (Result<GenresData, RequestError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private let baseURL = "https://api.themoviedb.org/3"
    
    
    
    func executeMovieUrlRequest(for endUrl: String, completionHandler: @escaping (Result<MoviesData, RequestError>) -> Void) {
        let request = baseURL + "\(endUrl)"
        
        guard let url = URL(string: request) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            guard let value = try? JSONDecoder().decode(MoviesData.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            
            completionHandler(.success(value))
            
        }
        dataTask.resume()
    }
    
    func executeGenresUrlRequest(completionHandler: @escaping (Result<GenresData, RequestError>) -> Void) {
        let request = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=6485b76b569ed96963a3f0e786cd369c"
        
        guard let url = URL(string: request) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, err in
            
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            guard let value = try? JSONDecoder().decode(GenresData.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            
            completionHandler(.success(value))
            
        }
        dataTask.resume()
    }
    
    func getImageDataFrom(url: URL, completionHandler: @escaping (Result<UIImage, RequestError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Data error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completionHandler(.success(image))
                }
            }
        }.resume()
    }
    
//    func getDetailedMovie(urlstring : String, completionHandler: @escaping (Result<MovieDetail, RequestError>) -> Void) {
//        
//        let request = baseURL + "\(urlstring)"
//        guard let url = URL(string: request) else {
//            completionHandler(.failure(.invalidURL))
//            return
//        }
//        
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, err in
//            
//            guard err == nil else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.clientError))
//                }
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.serverError))
//                }
//                return
//            }
//            
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.noDataError))
//                }
//                return
//            }
//            
//            guard let value = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.dataDecodingError))
//                }
//                return
//            }
//            
//            completionHandler(.success(value))
//            
//        }
//        dataTask.resume()
//    }
    

}

enum RequestError : Error {
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
    case invalidURL
}

enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}
