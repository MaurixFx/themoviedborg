//
//  HomeMoviesWireframe.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation

class HomeMoviesWireframe: HomeMoviesWireFrameProtocol {
    
    static func createHomeMoviesViewModule(homeMoviesViewRef: HomeMoviesView) {
        let presenter: HomeMoviesPresenterProtocol & HomeMoviesOutputInteractorProtocol = HomeMoviesPresenter()
        homeMoviesViewRef.presenter = presenter
        homeMoviesViewRef.presenter?.view = homeMoviesViewRef
        homeMoviesViewRef.presenter?.interactor = HomeMoviesInteractor()
        homeMoviesViewRef.presenter?.interactor?.presenter = presenter
    }
    
    
    
}
