//
//  Movies.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movies: NSObject {
    
    var id: Int
    var title: String
    var overview: String
    var dateMovie: String
    var voteAverage: Int
    var language: String
    var imageMovie: String
    
    init(data: JSON) {
        id = data["id"].intValue
        title = data["title"].stringValue
        overview = data["overview"].stringValue
        dateMovie = data["release_date"].stringValue
        voteAverage = data["vote_average"].intValue
        language = data["original_language"].stringValue
        imageMovie = data["poster_path"].stringValue
    }
}
