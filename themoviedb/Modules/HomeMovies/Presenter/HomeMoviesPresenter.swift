//
//  HomeMoviesPresenter.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class HomeMoviesPresenter: HomeMoviesPresenterProtocol {
    
    //Presenter ----> Interactor
    var interactor: HomeMoviesInputInteractorProtocol?
    //Presenter ----> View
    var view: HomeMoviesViewProtocol?
    var moviesList: [Movies] = []
    var typesMovie = [TypeMovie]()
    var pickerView = UIPickerView()
    let detailPopUp = DetailPopup()
    
    func getMoviesByType(type: String) {
        interactor?.performGetMovies(typeMovie: type)
    }
    
    func setupView(tableView: UITableView, view: UIView, viewHeader: UIView, titleFilter: UILabel, txtFilter: UITextField) {
        view.backgroundColor = UIColor.white
        addComponentsInView(view: view, tableView: tableView, viewHeader: viewHeader, titleFilter: titleFilter, txtFilter: txtFilter)
    }
    
    func addComponentsInView(view: UIView, tableView: UITableView, viewHeader: UIView, titleFilter: UILabel, txtFilter: UITextField) {
        view.addSubview(viewHeader)
        viewHeader.addSubview(titleFilter)
        viewHeader.addSubview(txtFilter)
        view.addSubview(tableView)
        setupConstraints(view: view, viewHeader: viewHeader, titleFilter: titleFilter, txtFilter: txtFilter, tableView: tableView)
    }
    
    func setupConstraints(view: UIView, viewHeader: UIView, titleFilter: UILabel, txtFilter: UITextField, tableView: UITableView) {
        viewHeader.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: getTopConstraintViewHeader(), paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 80)
        titleFilter.anchor(top: viewHeader.topAnchor, left: viewHeader.leftAnchor, bottom: nil, right: viewHeader.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15, paddingBottom: 0, width: 0, height: 18)
        txtFilter.anchor(top: titleFilter.bottomAnchor, left: viewHeader.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 15, paddingRight: 0, paddingBottom: 0, width: 200, height: 30)
        tableView.anchor(top: viewHeader.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    func setupTable(tableView: UITableView) {
        tableView.register(MovieCell.self, forCellReuseIdentifier: "movieCell")
    }
        
    func getCellFormat(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        let cellMovie = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cellMovie.setupCell()
        cellMovie.delegate = self
        cellMovie.displayDataInCell(movie: moviesList[indexPath.row])
        return cellMovie
    }
    
    func getHeightForRow() -> CGFloat {
        return 70.0
    }
    
    func getCountMovies() -> Int {
        return moviesList.count
    }
    
    func createDataTypeMovie() {
        var type = TypeMovie(id: 1, name: "Popular")
        typesMovie.append(type)
        type = TypeMovie(id: 2, name: "Top Rated")
        typesMovie.append(type)
    }
    
    func getFirstElementPicker() -> String {
        return typesMovie[0].name
    }
    
    func getCountTypesMovie() -> Int {
        return typesMovie.count
    }
    
    func getTypesMovieForRow(row: Int) -> TypeMovie {
        return typesMovie[row]
    }
    
}

//MARK:- Extension HomeMoviesOutputInteractorProtocol
extension HomeMoviesPresenter : HomeMoviesOutputInteractorProtocol {
    func displayMovies(listMovies: [Movies]) {
        moviesList = listMovies
        view?.displayMovies()
    }

    func requestWithError(message: String) {
        view?.showErrorMessage(message: message)
    }
}

//MARK:- Extension MovieCellDelegate
extension HomeMoviesPresenter: MovieCellDelegate {
    func didPressDetailMovie(movie: Movies) {
        if let window = UIApplication.shared.keyWindow {
            detailPopUp.showDetailMovie(window: window, movie: movie)
        }
    }
}

