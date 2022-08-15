//
//  URL+Extension.swift
//  MediaProject
//
//  Created by Carki on 2022/08/09.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let youtubrBaseURL = "https://www.youtube.com/watch?v="
    static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let weatherImageURL = "http://openweathermap.org/img/wn/"
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    static func makeYoutubeEndPointString() -> String {
        return youtubrBaseURL
    }
    
    static func makeWeatherEndPointString() -> String {
        return weatherBaseURL
    }
        
   
    
}

enum endPoint {
    static let weatherImageURL = "http://openweathermap.org/img/wn/"
    
}
