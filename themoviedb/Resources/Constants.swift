//
//  Constants.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import UIKit

let basePathImageUrl = "http://image.tmdb.org/t/p/w500"

//MARK:- CONSTANTS AND FUNCTIONS FOR DEVICES
//MARK:- NAME DEVICES
let IPHONE_SE = "iPhone SE"
let IPHONE_4S = "iPhone 4S"
let IPHONE_X = "iPhone X"

func isSmallDevice() -> Bool {
    return UIDevice().type.rawValue == IPHONE_4S || UIDevice().type.rawValue == IPHONE_SE
}

func isIphoneX() -> Bool {
    return UIDevice().type.rawValue == IPHONE_X
}

func getUrlImage(path: String) -> String {
    return basePathImageUrl + path
}

func getTopConstraintViewHeader() -> CGFloat {
    return isIphoneX() ? 40 : 20
}

//MARK:- ENDPOINTS
func getUrlPopularMovies() -> String {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        return dict["URL_POPULAR_MOVIES"] as! String
    }
    return ""
}

func getUrlTopRatedMovies() -> String {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        return dict["URL_TOPRATED_MOVIES"] as! String
    }
    return ""
}

