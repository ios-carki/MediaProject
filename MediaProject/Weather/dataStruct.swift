//
//  dataStruct.swift
//  MediaProject
//
//  Created by Carki on 2022/08/16.
//

import Foundation

struct datastruct {
    var temp: Double
    var humidity: String
    var wind: Double
    var icon: String
    
    init(temp: Double, humidity: String, wind: Double, icon: String) {
        self.temp = temp
        self.humidity = humidity
        self.wind = wind
        self.icon = icon
    }
}
