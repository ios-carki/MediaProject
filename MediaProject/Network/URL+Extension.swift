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
    
    static func makeEndPointString(_ endPoint: String) -> String {
        return baseURL + endPoint
    }
    
    static func makeYoutubeEndPointString() -> String {
        return youtubrBaseURL
    }
        
   
    
}
