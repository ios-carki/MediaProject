//
//  Endpoint.swift
//  MediaProject
//
//  Created by Carki on 2022/08/09.
//

import Foundation

//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

enum Endpoint {
    case base
    case video
//    case weather
    
    var requestURL: String {
        switch self {
        case .base:
            return URL.makeEndPointString("trending/tv/week?api_key=\(APIKey.TMDB)")
        case .video:
            return URL.makeEndPointString("tv/\(tvID)/videos?api_key=\(APIKey.TMDB)")
//        case .weather:
//            return URL.makeWeatherEndPointString("lat={lat}&lon={lon}&appid=\(APIKey.OpenWeather)")
            
        }
    }
}

func tvID(id: Int) -> Int {
    return id
}
//"https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.TMDB)"
//"https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/videos?api_key=\(APIKey.TMDB)"
//static let baseURL = "https://api.themoviedb.org/3/"
