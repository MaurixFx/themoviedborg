//
//  MovieCell.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol MovieCellDelegate: class {
    func didPressDetailMovie(movie: Movies)
}

class MovieCell: UITableViewCell {
    
    //Create ImageView
    let imageMovie: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    //MARK:- Create Labels
    let titleMovieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    let viewContentButton: UIView = {
        var view = UIView()
        view.target(forAction: #selector(handleDisplayDetail), withSender: self)
        return view
    }()
    
    //MARK:- Create Button
    lazy var moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "002-camera"), for: .normal)
        button.addTarget(self, action: #selector(handleDisplayDetail), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Variables
    var myMovie: Movies?
    weak var delegate: MovieCellDelegate?
    
    //MARK:- Setup Cell
    func setupCell() {
        addComponentInCell()
        setupGesture()
        setupConstraints()
    }
    
    func addComponentInCell() {
        addSubview(viewContentButton)
        viewContentButton.addSubview(moreInfoButton)
        addSubview(titleMovieLabel)
        addSubview(voteAverageLabel)
        addSubview(imageMovie)
    }
    
    //MARK:- Setup Constraints
    func setupConstraints() {
        imageMovie.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 60, height: 60)
        viewContentButton.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        moreInfoButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingRight: 10, paddingBottom: 0, width: 40, height: 40)
        
        titleMovieLabel.anchor(top: topAnchor, left: imageMovie.rightAnchor, bottom: nil, right: moreInfoButton.leftAnchor, paddingTop: 13, paddingLeft: 10, paddingRight: 10, paddingBottom: 0, width: 0, height: 18)
        voteAverageLabel.anchor(top: titleMovieLabel.bottomAnchor, left: imageMovie.rightAnchor, bottom: nil, right: titleMovieLabel.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: 0, height: 18)
    }
    
    func setupGesture() {
        let optionAction = UITapGestureRecognizer(target: self, action: #selector(handleDisplayDetail))
        viewContentButton.addGestureRecognizer(optionAction)
        viewContentButton.isUserInteractionEnabled = true
    }
    
    //MARK:- Display Data
    func displayDataInCell(movie: Movies) {
        myMovie = movie
        titleMovieLabel.text = movie.title
        voteAverageLabel.text = "Nota: \(movie.voteAverage)"
        imageMovie.sd_setImage(with: URL(string: getUrlImage(path: movie.imageMovie)), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
    }
    
    //MARK:- Actions
    @objc func handleDisplayDetail() {
        guard let movie = myMovie else { return }
        delegate?.didPressDetailMovie(movie: movie)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


