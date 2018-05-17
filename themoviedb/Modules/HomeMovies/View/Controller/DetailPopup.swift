//
//  DetailPopup.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class DetailPopup: NSObject {
    
    //MARK:- Create View
    var viewContent: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.904109589)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    //Create ImageView
    let imageMovie: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    //MARK:- Create Labels
    var titleMovieLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    var titleDateReleaseLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    var titleVoteAverageLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    var titleLanguageLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    var descriptionMovieLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
  
    //MARK:- Create Buttons
    lazy var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Variables
    let blackView = UIView()

    func initView(window: UIWindow) {
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        window.addSubview(blackView)
        window.addSubview(viewContent)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        blackView.frame = window.frame
        blackView.alpha = 0
        viewContent.alpha = 0
        setupShadow()
    }
    
    func setupView(window: UIWindow, movie: Movies) {
        initView(window: window)
        addComponents()
        setupConstraints()
        displayDetailData(movie: movie)
    }
    
    func addComponents() {
        viewContent.addSubview(titleMovieLabel)
        viewContent.addSubview(imageMovie)
        viewContent.addSubview(titleDateReleaseLabel)
        viewContent.addSubview(titleVoteAverageLabel)
        viewContent.addSubview(titleLanguageLabel)
        viewContent.addSubview(descriptionMovieLabel)
        viewContent.addSubview(closeButton)
    }

    func setupShadow() {
        viewContent.layer.shadowColor = UIColor.black.cgColor
        viewContent.layer.shadowRadius = 2.0
        viewContent.layer.shadowOpacity = 1.0
        viewContent.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewContent.layer.masksToBounds = false
    }
    
    func setupConstraints() {
        imageMovie.anchor(top: viewContent.topAnchor, left: viewContent.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        closeButton.anchor(top: viewContent.topAnchor, left: nil, bottom: nil, right: viewContent.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 12, paddingBottom: 0, width: 30, height: 30)
        titleMovieLabel.anchor(top: viewContent.topAnchor, left: imageMovie.rightAnchor, bottom: nil, right: viewContent.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingRight: 12, paddingBottom: 0, width: 0, height: 18)
        titleDateReleaseLabel.anchor(top: titleMovieLabel.bottomAnchor, left: imageMovie.rightAnchor, bottom: nil, right: viewContent.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingRight: 12, paddingBottom: 0, width: 0, height: 18)
        titleVoteAverageLabel.anchor(top: titleDateReleaseLabel.bottomAnchor, left: imageMovie.rightAnchor, bottom: nil, right: viewContent.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingRight: 12, paddingBottom: 0, width: 0, height: 18)
        titleLanguageLabel.anchor(top: titleVoteAverageLabel.bottomAnchor, left: imageMovie.rightAnchor, bottom: nil, right: viewContent.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingRight: 12, paddingBottom: 0, width: 0, height: 18)
        descriptionMovieLabel.anchor(top: imageMovie.bottomAnchor, left: viewContent.leftAnchor, bottom: nil, right: viewContent.rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 0)
    }
    
    func displayDetailData(movie: Movies) {
        titleMovieLabel.text = movie.title
        titleDateReleaseLabel.text = "Estreno: \(movie.dateMovie)"
        titleLanguageLabel.text = "Lenguaje: \(movie.language)"
        titleVoteAverageLabel.text = "Nota: \(movie.voteAverage)"
        descriptionMovieLabel.text = movie.overview
        imageMovie.sd_setImage(with: URL(string: getUrlImage(path: movie.imageMovie)), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload])
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.viewContent.alpha = 0
            self.viewContent.removeFromSuperview()
            self.blackView.removeFromSuperview()
        }
    }
    
    func showDetailMovie(window: UIWindow, movie: Movies) {
        setupView(window: window, movie: movie)
        //Animate Appear
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.viewContent.alpha = 1
            self.viewContent.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: isIphoneX() ? window.frame.width * 0.88 : isSmallDevice() ? window.frame.width * 0.93 : window.frame.width * 0.85, height: window.frame.size.height * 0.60)
            self.viewContent.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            self.viewContent.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        }, completion: nil)
    }
    
    
    override init() {
        super.init()
    }
}
