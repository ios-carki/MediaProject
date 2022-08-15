//
//  WeatherAPIManager.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import Foundation

import Alamofire
import SwiftyJSON

class WeatherAPIManager {
    static var shared = WeatherAPIManager()
    private init() {}
    
    func weatherDataRequest(lat: Double, longi: Double, completionHandler: @escaping (datastruct) -> () ) {
        let url = URL.weatherBaseURL + "lat=\(lat)&lon=\(longi)&appid=\(APIKey.OpenWeather)"
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let valueList = datastruct (
                    temp: json["main"]["temp"].doubleValue,
                    humidity: json["main"]["humidity"].stringValue,
                    wind: json["wind"]["speed"].doubleValue,
                    icon: json["weather"][0]["icon"].stringValue
                )
                
                completionHandler(valueList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
