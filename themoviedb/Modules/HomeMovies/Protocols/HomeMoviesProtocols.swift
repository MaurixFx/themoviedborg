//
//  HomeMoviesProtocols.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

protocol HomeMoviesViewProtocol: class {
    // PRESENTER -> VIEW
    func showErrorMessage(message:String)
    func displayMovies()
}

protocol HomeMoviesPresenterProtocol {
    //View -> Presenter
    var interactor: HomeMoviesInputInteractorProtocol? {get set}
    var view: HomeMoviesViewProtocol? {get set}
    var moviesList: [Movies] {get set}
    
    func getMoviesByType(type: String)
    func setupView(tableView: UITableView, view: UIView, viewHeader: UIView, titleFilter: UILabel, txtFilter: UITextField)
    func setupTable(tableView: UITableView)
    func getCellFormat(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func getHeightForRow() -> CGFloat
    func getCountMovies() -> Int
    func createDataTypeMovie()
    func getFirstElementPicker() -> String
    func getCountTypesMovie() -> Int
    func getTypesMovieForRow(row: Int) -> TypeMovie
}

protocol HomeMoviesInputInteractorProtocol {
    //Presenter -> Interactor
    var presenter: HomeMoviesOutputInteractorProtocol? {get set}
    func performGetMovies(typeMovie: String)
}

protocol HomeMoviesOutputInteractorProtocol {
    //Interactor -> Presenter
    func displayMovies(listMovies: [Movies])
    func requestWithError(message: String)
}

protocol HomeMoviesWireFrameProtocol {
    //Presenter -> Wireframe
    static func createHomeMoviesViewModule(homeMoviesViewRef: HomeMoviesView)
}


