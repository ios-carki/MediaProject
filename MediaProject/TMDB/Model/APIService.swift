//
//  APIService.swift
//  MediaProject
//
//  Created by Carki on 2023/01/05.
//

import Foundation

import Alamofire

final class APIService {
    
    func requestAPI(completionHandler: @escaping (Int ,TMDBData) -> ()) {
        let api = TMDB_API.requestTMDB

        AF.request(api.url, method: .get).validate(statusCode: 200..<400).responseDecodable(of: TMDBData.self) { response in

            switch response.result {
            case .success(let data):
                print("API호출 성공 ✅✅✅✅✅")
                completionHandler(response.response?.statusCode ?? 0, data)
                return
            case .failure:
                print("API호출 에러 ❌❌❌❌❌", response.response?.statusCode ?? 0)
                return
            }
        }
    }
    
    func requestCreditAPI(mediaID: String, completionHanlder: @escaping (Int, TMDBCredits) -> ()) {
        let api = TMDB_API.requestCredit(idName: mediaID)
        
        AF.request(api.url, method: .get).responseDecodable(of: TMDBCredits.self) { response in
            switch response.result {
            case .success(let data):
                print("크래딧 API 호출 성공: ✅✅✅✅✅")
                completionHanlder(response.response?.statusCode ?? 0, data)
                
                return
            case .failure:
                print("크래딧 API 호출 에러: ❌❌❌❌❌", response.response?.statusCode ?? 0)
                
                return
            }
        }
    }
}
