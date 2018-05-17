//
//  HomeMoviesInteractor.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import SwiftyJSON
import RappleProgressHUD

class HomeMoviesInteractor: HomeMoviesInputInteractorProtocol {
    
    //Interactor --> Presenter
    var presenter: HomeMoviesOutputInteractorProtocol?
    let manager = ApiManager()
    var moviesList = [Movies]()
    
    func performGetMovies(typeMovie: String) {
        startAnimationLoading()
        manager.requestAPI(url: typeMovie == "Popular" ? getUrlPopularMovies() : getUrlTopRatedMovies(), method: .get, parameters: nil) { (json, message, error) in
            self.stopAnimationLoading()
            if !error {
                guard let jsonResult = json else { return }
                self.mappMovies(data: jsonResult)
                self.presenter?.displayMovies(listMovies: self.moviesList)
            } else {
                self.presenter?.requestWithError(message: message)
            }
        }
    }
    
    func mappMovies(data: JSON) {
        moviesList.removeAll()
        for item in data["results"].arrayValue {
            let movie = Movies(data: item)
            moviesList.append(movie)
        }
    }
    
    func startAnimationLoading() {
        RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
    }
    
    func stopAnimationLoading() {
        RappleActivityIndicatorView.stopAnimation()
    }
}
