//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by Carki on 2022/08/09.
//

import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() {  }
    
    func callRequest(type: Endpoint, completionHandler: @escaping (JSON) -> ()) {
        //"https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.TMDB)"
        //"https://api.themoviedb.org/3/tv/\(UserDefaults.standard.integer(forKey: "id"))/videos?api_key=\(APIKey.TMDB)"
        
        var url = type.requestURL
        
        //validate - 유효성 검사
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let Json = JSON(value)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
}
