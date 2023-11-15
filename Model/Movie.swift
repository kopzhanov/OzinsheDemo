//
//  Movie.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 02.10.2023.
//

import Foundation
import SwiftyJSON

class Movie {
    public var id = 0
    public var movieType = ""
    public var name = ""
    public var keyWords = ""
    public var description = ""
    public var year = 0
    public var trend = false
    public var timing = 0
    public var director = ""
    public var producer = ""
    public var poster_link = ""
    public var video_link = ""
    public var watchCount = 0
    public var seasonCount = 0
    public var seriesCount = 0
    public var createdDate = ""
    public var lastModifiedDate = ""
    public var screenshots: [Screenshot] = []
    public var categoryAges: [CategoryAge] = []
    public var genres: [Genre] = []
    public var categories: [Category] = []
    public var favorite = false
    
    init() {
    }
    
    init(json: JSON) {
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["movieType"].string{
            self.movieType = temp
        }
        if let temp = json["name"].string{
            self.name = temp
        }
        if let temp = json["keyWords"].string{
            self.keyWords = temp
        }
        if let temp = json["description"].string{
            self.description = temp
        }
        if let temp = json["year"].int{
            self.year = temp
        }
        if let temp = json["trend"].bool{
            self.trend = temp
        }
        if let temp = json["timing"].int{
            self.timing = temp
        }
        if let temp = json["director"].string{
            self.director = temp
        }
        if let temp = json["producer"].string{
            self.producer = temp
        }
        if json["poster"].exists(){
            if let temp = json["poster"]["link"].string{
                self.poster_link = temp
            }
        }
        if json["video"].exists(){
            if let temp = json["video"]["link"].string{
                self.poster_link = temp
            }
        }
        if let temp = json["watchCount"].int{
            self.watchCount = temp
        }
        if let temp = json["seasonCount"].int{
            self.seasonCount = temp
        }
        if let temp = json["SeriesCount"].int{
            self.seriesCount = temp
        }
        if let temp = json["createdDate"].string{
            self.createdDate = temp
        }
        if let temp = json["lastModifiedDate"].string{
            self.lastModifiedDate = temp
        }
        if let array = json["screenshots"].array{
            for item in array{
                let temp = Screenshot(json: item)
                screenshots.append(temp)
            }
        }
        if let array = json["categoryAges"].array{
            for item in array{
                let temp = CategoryAge(json: item)
                categoryAges.append(temp)
            }
        }
        if let array = json["genres"].array{
            for item in array{
                let temp = Genre(json: item)
                genres.append(temp)
            }
        }
        if let array = json["categories"].array{
            for item in array{
                let temp = Category(json: item)
                categories.append(temp)
            }
        }
        if let temp = json["favorite"].bool{
            self.favorite = temp
        }
    }
}
