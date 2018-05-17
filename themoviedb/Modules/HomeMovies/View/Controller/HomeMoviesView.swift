//
//  HomeMoviesView.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class HomeMoviesView: UIViewController, HomeMoviesViewProtocol {
 
    //MARK:- Create UIVIew
    var viewHeader: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //MARK:- Create Labels
    var titleFilter: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.text = "Tipo de Peliculas"
        label.textAlignment = .left
        return label
    }()
    
    //MARK:- Create TextField
    var txtFilter: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1.0
        tf.returnKeyType = .done
        tf.autocapitalizationType = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        return tf
    }()
    
    //MARK:- Create TableView
    var tableView: UITableView = {
        var table = UITableView()
        table.separatorStyle = .none
        table.alwaysBounceVertical = false
        return table
    }()
    
    //MARK:- VARIABLES
    //View -----> Presenter
    var presenter: HomeMoviesPresenterProtocol!
    var pickerView = UIPickerView()
    var alert = SCLAlertView()

    
    //MARK:- Init View
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeMoviesWireframe.createHomeMoviesViewModule(homeMoviesViewRef: self)
        setupView()
        createDataTypeMovie()
        setupPickerView()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        presenter.setupView(tableView: tableView, view: view, viewHeader: viewHeader, titleFilter: titleFilter, txtFilter: txtFilter)
    }

    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        txtFilter.inputView = pickerView
        txtFilter.textAlignment = .center
        txtFilter.text = presenter.getFirstElementPicker()
        presenter.getMoviesByType(type: "Popular")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        presenter.setupTable(tableView: tableView)
    }
    
    func createDataTypeMovie() {
       presenter.createDataTypeMovie()
    }
    
    //MARK:- Actions
    func showErrorMessage(message: String) {
        alert.showError("Ups", subTitle: message)
    }
    
    func displayMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

//MARK:- Extension TableView
extension HomeMoviesView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountMovies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.getCellFormat(indexPath: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.getHeightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK:- PickerView Extension
extension HomeMoviesView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getCountTypesMovie()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getTypesMovieForRow(row: row).name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = presenter.getTypesMovieForRow(row: row).name
        txtFilter.text = name
        txtFilter.resignFirstResponder()
        presenter.getMoviesByType(type: name)
    }
}
